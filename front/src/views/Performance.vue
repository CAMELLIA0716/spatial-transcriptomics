<template>
  <div class="fade-in">
    <div class="card overflow-hidden">
      <div class="px-6 py-4 border-b border-slate-200 bg-gradient-to-r from-blue-50 to-white flex justify-between items-center">
        <div>
          <h3 class="text-base font-semibold text-slate-800">方法性能评估</h3>
          <p class="text-xs text-slate-500 mt-1">
            样本：<span class="font-semibold text-blue-600 bg-blue-100 px-2 py-0.5 rounded-md">{{ dataId }}</span>
          </p>
        </div>
        <div class="flex items-center space-x-2">
          <button
              @click="refreshTable"
              class="btn-secondary px-3 py-1.5 text-xs font-medium rounded-lg flex items-center space-x-1 hover:bg-blue-50 hover:text-blue-600 hover:border-blue-200"
          >
            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
            </svg>
            <span>刷新</span>
          </button>
        </div>
      </div>

      <div class="overflow-x-auto">
        <table class="min-w-full perf-table">
          <thead>
          <tr>
            <th rowspan="2" class="sticky left-0 z-20 bg-slate-50 border-r-2 border-slate-200 shadow-sm" style="min-width: 110px;">Method</th>
            <th colspan="3" class="metric-group-header text-blue-700 bg-blue-50/50">Accuracy</th>
            <th colspan="3" class="metric-group-header text-green-700 bg-green-50/50" style="border-left: 2px solid #e2e8f0;">Continuity</th>
            <th colspan="2" class="metric-group-header text-purple-700 bg-purple-50/50" style="border-left: 2px solid #e2e8f0;">Marker Score</th>
            <th rowspan="2" class="sticky right-0 z-20 bg-slate-50 border-l-2 border-slate-200 shadow-sm" style="min-width: 140px; max-width: 160px;">Visualizations</th>
          </tr>
          <tr class="table-header">
            <th class="w-20">NMI</th><th class="w-20">HOM</th><th class="w-20">COM</th>
            <th class="w-20">CHAOS</th><th class="w-20">PAS</th><th class="w-20">ASW</th>
            <th class="w-20">Moran'I</th><th class="w-20">Geary's C</th>
          </tr>
          </thead>
          <tbody class="divide-y divide-slate-100">
          <tr
              v-for="(row, index) in performances"
              :key="row.methodName"
              :class="[index % 2 === 0 ? 'bg-white' : 'bg-slate-50', 'table-row']"
          >
            <td class="method-name">{{ row.methodName }}</td>
            <td :class="['value-cell', getValueClass(row.nmi)]">{{ row.nmi?.toFixed(2) }}</td>
            <td :class="['value-cell', getValueClass(row.hom)]">{{ row.hom?.toFixed(2) }}</td>
            <td :class="['value-cell', getValueClass(row.com)]">{{ row.com?.toFixed(2) }}</td>
            <td :class="['value-cell', getValueClass(row.chaos, true)]">{{ row.chaos?.toFixed(2) }}</td>
            <td :class="['value-cell', getValueClass(row.pas)]">{{ row.pas?.toFixed(2) }}</td>
            <td :class="['value-cell', getValueClass(row.asw)]">{{ row.asw?.toFixed(2) }}</td>
            <td :class="['value-cell', getValueClass(row.moran)]">{{ row.moran?.toFixed(2) }}</td>
            <td :class="['value-cell', getValueClass(row.geary)]">{{ row.geary?.toFixed(2) }}</td>
            <td class="viz-col">
              <div class="flex flex-row space-x-1 justify-center w-full">
                <button
                    v-for="viz in vizTypes"
                    :key="viz.name"
                    @click="openVizModal(viz.name, row.methodName)"
                    :class="['viz-btn flex-1 text-center font-medium text-white rounded-md shadow-sm hover:shadow-md truncate', viz.class]"
                    :title="viz.name"
                >
                  {{ viz.name }}
                </button>
              </div>
            </td>
          </tr>
          <tr v-if="loading && performances.length === 0">
            <td colspan="10" class="text-center py-8 text-slate-500">加载中...</td>
          </tr>
          </tbody>
        </table>
      </div>

      <div class="px-6 py-4 border-t border-slate-200 bg-slate-50 flex justify-between items-center">
        <p class="text-sm text-slate-500">
          显示 {{ (currentPage - 1) * pageSize + 1 }} 到 {{ Math.min(currentPage * pageSize, totalElements) }} 条，共 {{ totalElements }} 条结果
        </p>
        <Pagination
            :currentPage="currentPage"
            :totalPages="totalPages"
            @page-change="handlePageChange"
        />
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, watch, inject } from 'vue'
import Pagination from '../components/common/Pagination.vue'

const props = defineProps({
  dataId: {
    type: String,
    required: true
  }
})

const api = inject('api')
const modals = inject('modals')

const performances = ref([])
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(8)
const totalElements = ref(0)
const totalPages = ref(0)

const vizTypes = [
  { name: '空间表征图', class: 'bg-gradient-to-r from-blue-500 to-cyan-500' },
  { name: '差异表征图', class: 'bg-gradient-to-r from-purple-500 to-pink-500' }
]

const getValueClass = (val, isChaos = false) => {
  if (!val) return ''
  const num = Number(val)
  if (isChaos) return num <= 0.70 ? 'value-high' : num <= 0.75 ? 'value-mid' : 'value-low'
  return num >= 0.75 ? 'value-high' : num >= 0.65 ? 'value-mid' : 'value-low'
}

const loadPerformances = async () => {
  loading.value = true
  try {
    const response = await api.getPerformance(props.dataId, {
      page: currentPage.value - 1,
      size: pageSize.value
    })
    performances.value = response.data.content
    totalElements.value = response.data.totalElements
    totalPages.value = response.data.totalPages
  } catch (error) {
    console.error('加载性能数据失败:', error)
  } finally {
    loading.value = false
  }
}

const handlePageChange = (page) => {
  currentPage.value = page
  loadPerformances()
}

const refreshTable = () => {
  currentPage.value = 1
  loadPerformances()
}

const openVizModal = (type, method) => {
  modals.openVizModal(type, method, props.dataId)
}

watch(() => props.dataId, () => {
  loadPerformances()
}, { immediate: true })
</script>

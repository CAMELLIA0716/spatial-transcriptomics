<template>
  <div class="fade-in">
    <div class="mb-5 flex items-center space-x-2">
      <button
          @click="switchSubtab('home')"
          :class="[
          'px-4 py-2 text-sm font-medium rounded-lg transition-all',
          currentSubtab === 'home'
            ? 'bg-blue-600 text-white shadow-md'
            : 'bg-white text-slate-600 hover:bg-slate-50 border border-slate-200'
        ]"
      >
        典型数据 (Home)
      </button>
      <button
          @click="switchSubtab('nonTypical')"
          :class="[
          'px-4 py-2 text-sm font-medium rounded-lg transition-all',
          currentSubtab === 'nonTypical'
            ? 'bg-blue-600 text-white shadow-md'
            : 'bg-white text-slate-600 hover:bg-slate-50 border border-slate-200'
        ]"
      >
        非典型数据 (Non-typical)
      </button>
    </div>

    <div class="card overflow-hidden">
      <div class="px-6 py-4 border-b border-slate-200 bg-gradient-to-r from-slate-50 to-white flex justify-between items-center">
        <h3 class="text-base font-semibold text-slate-800">数据集列表</h3>
        <div class="flex items-center space-x-3">
          <button
              @click="openNewDatasetModal"
              class="btn-primary px-4 py-2 text-sm font-medium text-white rounded-lg flex items-center space-x-2 shadow-sm"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path>
            </svg>
            <span>新建</span>
          </button>
          <input
              type="text"
              placeholder="搜索样本ID..."
              class="text-sm border border-slate-200 rounded-lg px-4 py-2 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 w-56 bg-white/50"
              v-model="searchQuery"
              @input="debouncedSearch"
          >
        </div>
      </div>

      <div class="overflow-x-auto">
        <table class="min-w-full">
          <thead class="table-header">
          <tr>
            <th class="px-4 py-3 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">样本ID</th>
            <th class="px-4 py-3 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">Spatial Technology</th>
            <th class="px-4 py-3 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">Size/Radius</th>
            <th class="px-4 py-3 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">Spots</th>
            <th class="px-4 py-3 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">Genes</th>
            <th class="px-4 py-3 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">Sparsity</th>
            <th class="px-4 py-3 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">Annotation</th>
            <th class="px-4 py-3 text-left text-xs font-semibold text-slate-600 uppercase tracking-wider">Performance</th>
          </tr>
          </thead>
          <tbody class="divide-y divide-slate-100">
          <tr
              v-for="(row, index) in datasets"
              :key="row.dataId"
              :class="[index % 2 === 0 ? 'bg-white' : 'bg-slate-50', 'table-row']"
          >
            <td class="px-4 py-3 text-sm font-semibold text-slate-800">{{ row.dataId }}</td>
            <td class="px-4 py-3 text-sm text-slate-600">{{ row.technology }}</td>
            <td class="px-4 py-3 text-sm text-slate-600">{{ row.size }}</td>
            <td class="px-4 py-3 text-sm text-slate-600">{{ row.spots?.toLocaleString() }}</td>
            <td class="px-4 py-3 text-sm text-slate-600">{{ row.genes?.toLocaleString() }}</td>
            <td class="px-4 py-3 text-sm text-slate-600">{{ row.sparsity }}</td>
            <td class="px-4 py-3 text-sm text-slate-600">{{ row.annotation }}</td>
            <td class="px-4 py-3 text-sm">
              <button
                  @click="$emit('view-performance', row.dataId)"
                  class="btn-primary px-3 py-1.5 text-xs font-medium text-white rounded-lg transition-all shadow-sm"
              >
                Performance
              </button>
            </td>
          </tr>
          <tr v-if="loading && datasets.length === 0">
            <td colspan="8" class="text-center py-8 text-slate-500">
              <svg class="animate-spin h-5 w-5 mx-auto mb-2" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              加载中...
            </td>
          </tr>
          <tr v-if="!loading && datasets.length === 0">
            <td colspan="8" class="text-center py-8 text-slate-500">暂无数据</td>
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
import { useDebounce } from '@vueuse/core'
import Pagination from '../components/common/Pagination.vue'

const emit = defineEmits(['view-performance'])
const api = inject('api')
const modals = inject('modals')

const currentSubtab = ref('home')
const datasets = ref([])
const loading = ref(false)
const currentPage = ref(1)
const pageSize = ref(5)
const totalElements = ref(0)
const totalPages = ref(0)
const searchQuery = ref('')
const debouncedSearch = useDebounce(searchQuery, 500)

const loadDatasets = async () => {
  loading.value = true
  try {
    const params = {
      type: currentSubtab.value,
      page: currentPage.value - 1,
      size: pageSize.value
    }
    if (searchQuery.value) {
      params.search = searchQuery.value
    }

    const response = await api.getDatasets(params)
    datasets.value = response.data.content
    totalElements.value = response.data.totalElements
    totalPages.value = response.data.totalPages
  } catch (error) {
    console.error('加载数据集失败:', error)
  } finally {
    loading.value = false
  }
}

const switchSubtab = (subtab) => {
  currentSubtab.value = subtab
  currentPage.value = 1
  loadDatasets()
}

const handlePageChange = (page) => {
  currentPage.value = page
  loadDatasets()
}

watch(debouncedSearch, () => {
  currentPage.value = 1
  loadDatasets()
})

const openNewDatasetModal = () => {
  modals.openNewDatasetModal()
}

loadDatasets()
</script>

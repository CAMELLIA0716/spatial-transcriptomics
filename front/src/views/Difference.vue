<template>
  <div class="fade-in space-y-6">
    <!-- 搜索框 -->
    <div class="card p-4 flex justify-center items-center shadow-sm">
      <div class="flex items-center space-x-3 w-full max-w-md">
        <div class="relative flex-1">
          <input type="text" placeholder="样本ID (如 151508)" v-model="searchDataId" class="w-full pl-9 pr-3 py-2 border rounded-lg">
          <svg class="w-4 h-4 absolute left-3 top-3 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
        </div>
        <button @click="analyzeSample" class="btn-primary px-4 py-2 text-sm font-medium text-white rounded-lg flex items-center space-x-2 shadow-sm">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
          </svg>
          <span>分析</span>
        </button>
      </div>
    </div>

    <!-- 准确率图表 -->
    <div class="card p-6">
      <div class="flex justify-between items-center mb-2">
        <h3 class="text-lg font-bold text-slate-800">方法准确率对比</h3>
        <span class="text-xs text-slate-500 bg-slate-100 px-2 py-1 rounded">Metric: Accuracy Score</span>
      </div>
      <div ref="accuracyChartRef" style="width:100%;height:450px;"></div>
    </div>

    <!-- 交互式仪表板（空间差异交互视图） -->
    <div v-if="hasDashboard" class="card p-6">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-lg font-bold">交互式仪表板</h3>
        <div class="flex items-center space-x-4">
          <div class="flex items-center space-x-4 text-xs">
            <span class="flex items-center"><span class="w-3 h-3 rounded-full bg-red-500 mr-2 shadow"></span>High Complexity</span>
            <span class="flex items-center"><span class="w-3 h-3 rounded-full bg-yellow-500 mr-2 shadow"></span>Medium</span>
            <span class="flex items-center"><span class="w-3 h-3 rounded-full bg-green-500 mr-2 shadow"></span>Low</span>
          </div>
          <button @click="refreshDashboard" class="text-blue-600 hover:text-blue-800 text-sm flex items-center">
            <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"></path>
            </svg>
            刷新
          </button>
        </div>
      </div>
      <iframe :src="dashboardUrl" class="w-full h-[600px] border rounded" frameborder="0"></iframe>
      <p class="text-xs text-slate-500 mt-3 text-center italic flex items-center justify-center">
        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
        </svg>
        提示：鼠标悬停在点位上查看详细信息
      </p>
    </div>

    <!-- 空间差异交互地图（备用，当HTML文件不可用时显示） -->
    <div v-else class="card p-6">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-lg font-bold text-slate-800">空间差异交互视图</h3>
        <div class="flex items-center space-x-4 text-xs">
          <span class="flex items-center"><span class="w-3 h-3 rounded-full bg-red-500 mr-2 shadow"></span>High Complexity</span>
          <span class="flex items-center"><span class="w-3 h-3 rounded-full bg-yellow-500 mr-2 shadow"></span>Medium</span>
          <span class="flex items-center"><span class="w-3 h-3 rounded-full bg-green-500 mr-2 shadow"></span>Low</span>
        </div>
      </div>
      <div ref="mapContainer" class="interactive-map-container" id="interactive-map">
        <div id="spot-tooltip" class="spot-tooltip"></div>
      </div>
      <p class="text-xs text-slate-500 mt-3 text-center italic flex items-center justify-center">
        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
        </svg>
        提示：鼠标悬停在点位上查看详细信息
      </p>
    </div>

    <!-- Spot详情表格 -->
    <div class="card p-6">
      <h3 class="text-lg font-bold mb-4">Spot级别差异性详情</h3>
      <div class="overflow-x-auto border rounded">
        <table class="min-w-full">
          <thead class="bg-slate-50">
          <tr>
            <th class="px-4 py-3 text-left text-xs font-semibold uppercase">Spot Name</th>
            <th class="px-4 py-3 text-left text-xs font-semibold uppercase">Consistency Score</th>
            <th class="px-4 py-3 text-left text-xs font-semibold uppercase">Complexity</th>
            <th class="px-4 py-3 text-left text-xs font-semibold uppercase">X Coord</th>
            <th class="px-4 py-3 text-left text-xs font-semibold uppercase">Y Coord</th>
          </tr>
          </thead>
          <tbody>
          <tr v-for="(row, idx) in differenceData" :key="row.spotName" :class="idx % 2 === 0 ? 'bg-white' : 'bg-slate-50'">
            <td class="px-4 py-3 text-sm font-mono">{{ row.spotName }}</td>
            <td class="px-4 py-3 text-sm" :class="row.consistency > 0.8 ? 'text-green-600' : ''">{{ row.consistency.toFixed(2) }}</td>
            <td class="px-4 py-3 text-sm">
                <span :class="['px-2 py-1 rounded-full text-xs font-semibold',
                  row.level === 'High' ? 'bg-red-100 text-red-700' :
                  row.level === 'Medium' ? 'bg-yellow-100 text-yellow-700' :
                  'bg-green-100 text-green-700']">{{ row.level }}</span>
            </td>
            <td class="px-4 py-3 text-sm">{{ row.x }}</td>
            <td class="px-4 py-3 text-sm">{{ row.y }}</td>
          </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch, inject, nextTick } from 'vue'
import Plotly from 'plotly.js-dist-min'

const props = defineProps({
  dataId: {
    type: String,
    default: '151508'
  }
})

const api = inject('api')
const modals = inject('modals')

const searchDataId = ref(props.dataId)
const differenceData = ref([])
const accuracyData = ref([])
const hasDashboard = ref(false)
const dashboardUrl = ref('')
const accuracyChartRef = ref(null)
const mapContainer = ref(null)

const loadAccuracy = async () => {
  try {
    const res = await api.getAccuracy(searchDataId.value)
    accuracyData.value = res.data
    renderAccuracyChart()
  } catch (error) {
    console.error('加载准确率失败:', error)
  }
}

const loadDifferenceSpots = async () => {
  try {
    const res = await api.getDifferenceSpots(searchDataId.value)
    differenceData.value = res.data
    renderMap()
  } catch (error) {
    console.error('加载差异点失败:', error)
  }
}

const loadDashboardInfo = async () => {
  try {
    const url = api.getDashboardUrl(searchDataId.value)
    // 尝试获取 dashboard 是否存在，可以通过 HEAD 请求，但简化：直接设置 url
    hasDashboard.value = true  // 假设存在，实际应检查
    dashboardUrl.value = url
  } catch (error) {
    hasDashboard.value = false
  }
}

const refreshDashboard = () => {
  const temp = dashboardUrl.value
  dashboardUrl.value = ''
  nextTick(() => {
    dashboardUrl.value = temp
  })
}

const analyzeSample = () => {
  if (searchDataId.value) {
    loadAccuracy()
    loadDifferenceSpots()
    loadDashboardInfo()
  }
}

const renderAccuracyChart = () => {
  if (!accuracyChartRef.value || accuracyData.value.length === 0) return
  
  // 过滤掉ground_truth数据
  const filteredData = accuracyData.value.filter(d => d.method !== 'ground_truth')
  
  const trace = {
    x: filteredData.map(d => d.score),
    y: filteredData.map(d => d.method),
    type: 'bar',
    orientation: 'h',
    marker: {
      color: '#3b82f6', // 统一使用蓝色
      line: {
        width: 1,
        color: '#ffffff'
      },
      linewidth: 0,
      // 添加圆角效果
      cornerradius: 4
    },
    text: filteredData.map(d => d.score.toFixed(4)),
    textposition: 'outside',
    hoverinfo: 'x+y+text',
    hovertemplate: '<b>%{y}</b><br>Accuracy: %{text}<extra></extra>'
  }
  
  const layout = {
    title: {
      text: 'Method Accuracy Comparison',
      font: {
        size: 16,
        weight: 'bold'
      },
      x: 0.5,
      xanchor: 'center'
    },
    xaxis: {
      title: {
        text: 'Accuracy Score',
        font: {
          size: 14
        }
      },
      range: [0, 1],
      tickformat: '.2f',
      gridcolor: '#f0f0f0'
    },
    yaxis: {
      title: {
        text: 'Method',
        font: {
          size: 14
        },
        standoff: 20
      },
      tickfont: {
        size: 12
      }
    },
    margin: {
      l: 150,
      r: 60,
      t: 60,
      b: 40
    },
    paper_bgcolor: 'rgba(0,0,0,0)',
    plot_bgcolor: 'rgba(0,0,0,0)',
    autosize: true,
    bargap: 0.2,
    animations: {
      startup: {
        duration: 1000,
        easing: 'cubic-in-out'
      }
    }
  }
  
  const config = {
    responsive: true,
    displayModeBar: false,
    staticPlot: false
  }
  
  Plotly.newPlot(accuracyChartRef.value, [trace], layout, config)
}

const renderMap = () => {
  if (!mapContainer.value || differenceData.value.length === 0) return
  const container = mapContainer.value
  // 清除所有现有点
  const existingSpots = container.querySelectorAll('.map-spot')
  existingSpots.forEach(spot => spot.remove())

  differenceData.value.forEach(spot => {
    const el = document.createElement('div')
    el.className = 'map-spot'
    let color = '#22c55e'
    if (spot.level === 'High') color = '#ef4444'
    else if (spot.level === 'Medium') color = '#eab308'
    el.style.backgroundColor = color
    el.style.left = spot.x + 'px'
    el.style.top = spot.y + 'px'
    // 添加悬停事件
    el.addEventListener('mouseenter', (e) => {
      const tooltip = document.getElementById('spot-tooltip')
      tooltip.innerHTML = `
        <div class="tooltip-title">${spot.spotName}</div>
        <div class="tooltip-row"><span class="tooltip-label">Consistency:</span> <span class="tooltip-value">${spot.consistency.toFixed(2)}</span></div>
        <div class="tooltip-row"><span class="tooltip-label">Complexity:</span> <span class="tooltip-value" style="color:${color}">${spot.level}</span></div>
      `
      tooltip.style.left = e.pageX + 'px'
      tooltip.style.top = e.pageY + 'px'
      tooltip.style.opacity = '1'
    })
    el.addEventListener('mousemove', (e) => {
      const tooltip = document.getElementById('spot-tooltip')
      tooltip.style.left = e.pageX + 'px'
      tooltip.style.top = e.pageY + 'px'
    })
    el.addEventListener('mouseleave', () => {
      const tooltip = document.getElementById('spot-tooltip')
      tooltip.style.opacity = '0'
    })
    container.appendChild(el)
  })
}

watch(() => searchDataId.value, (newVal) => {
  if (newVal) {
    loadAccuracy()
    loadDifferenceSpots()
    loadDashboardInfo()
  }
})

onMounted(() => {
  loadAccuracy()
  loadDifferenceSpots()
  loadDashboardInfo()
})
</script>

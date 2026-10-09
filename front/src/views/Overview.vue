<template>
  <div class="fade-in space-y-8">
    <!-- Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      <div class="card p-6 stat-card group">
        <div class="flex items-center justify-between mb-4">
          <div>
            <p class="text-sm text-slate-500 font-medium uppercase tracking-wider">收录方法数</p>
            <p class="text-4xl font-bold text-slate-800 mt-2">{{ stats.methodCount }}</p>
          </div>
          <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-blue-100 to-blue-200 flex items-center justify-center shadow-sm group-hover:scale-110 transition-transform">
            <svg class="w-7 h-7 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
            </svg>
          </div>
        </div>
        <div class="flex items-center text-xs font-medium text-green-600 bg-green-50 w-fit px-2 py-1 rounded-full">
          <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
          </svg>
          <span>较上月 +2</span>
        </div>
      </div>

      <div class="card p-6 stat-card group">
        <div class="flex items-center justify-between mb-4">
          <div>
            <p class="text-sm text-slate-500 font-medium uppercase tracking-wider">样本总数</p>
            <p class="text-4xl font-bold text-slate-800 mt-2">{{ stats.datasetCount }}</p>
          </div>
          <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-purple-100 to-purple-200 flex items-center justify-center shadow-sm group-hover:scale-110 transition-transform">
            <svg class="w-7 h-7 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 7v10c0 2.21 3.582 4 8 4s8-1.79 8-4V7M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4M4 7c0-2.21 3.582-4 8-4s8 1.79 8 4"></path>
            </svg>
          </div>
        </div>
        <div class="flex items-center text-xs font-medium text-green-600 bg-green-50 w-fit px-2 py-1 rounded-full">
          <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
          </svg>
          <span>较上月 +12</span>
        </div>
      </div>

      <div class="card p-6 stat-card group">
        <div class="flex items-center justify-between mb-4">
          <div>
            <p class="text-sm text-slate-500 font-medium uppercase tracking-wider">支持物种</p>
            <p class="text-4xl font-bold text-slate-800 mt-2">{{ stats.speciesCount }}</p>
          </div>
          <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-green-100 to-green-200 flex items-center justify-center shadow-sm group-hover:scale-110 transition-transform">
            <svg class="w-7 h-7 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064"></path>
            </svg>
          </div>
        </div>
        <div class="flex items-center text-xs font-medium text-slate-500 bg-slate-100 w-fit px-2 py-1 rounded-full">
          <span>涵盖人、小鼠等</span>
        </div>
      </div>

      <div class="card p-6 stat-card group">
        <div class="flex items-center justify-between mb-4">
          <div>
            <p class="text-sm text-slate-500 font-medium uppercase tracking-wider">评估指标</p>
            <p class="text-4xl font-bold text-slate-800 mt-2">{{ stats.metricCount }}</p>
          </div>
          <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-orange-100 to-orange-200 flex items-center justify-center shadow-sm group-hover:scale-110 transition-transform">
            <svg class="w-7 h-7 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
            </svg>
          </div>
        </div>
        <div class="flex items-center text-xs font-medium text-blue-600 bg-blue-50 w-fit px-2 py-1 rounded-full">
          <span>三大类评估体系</span>
        </div>
      </div>
    </div>

    <!-- Features Grid -->
    <div>
      <h3 class="text-lg font-bold text-slate-800 mb-4 flex items-center">
        <span class="w-1 h-6 bg-blue-500 rounded-full mr-3"></span>
        平台核心特性
      </h3>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <div v-for="(feature, index) in features" :key="index" class="card p-5 hover:shadow-lg transition-shadow">
          <div class="flex items-start space-x-4">
            <div :class="['p-3 rounded-lg', feature.iconBg]" v-html="feature.icon"></div>
            <div>
              <h4 class="font-semibold text-slate-800">{{ feature.title }}</h4>
              <p class="text-sm text-slate-500 mt-1 leading-relaxed">{{ feature.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, inject } from 'vue'

const api = inject('api')
const stats = ref({
  methodCount: 0,
  datasetCount: 0,
  speciesCount: 0,
  metricCount: 0
})

const features = [
  {
    iconBg: 'bg-blue-50 text-blue-600',
    icon: '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path></svg>',
    title: '全面基准测试',
    description: '涵盖 Visium, Stereo-seq, Slide-seqV2 等主流技术，提供标准化的性能评估流程。'
  },
  {
    iconBg: 'bg-purple-50 text-purple-600',
    icon: '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 12l3-3 3 3 4-4M8 21l4-4 4 4M3 4h18M4 4h16v12a1 1 0 01-1 1H5a1 1 0 01-1-1V4z"></path></svg>',
    title: '多维度评估指标',
    description: '集成 Accuracy, Continuity, Marker Score 等 8 项核心指标，全方位量化算法表现。'
  },
  {
    iconBg: 'bg-green-50 text-green-600',
    icon: '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path></svg>',
    title: '交互式可视化',
    description: '提供空间表征与差异表征的动态视图，支持鼠标悬停查看 Spot 级别详细信息。'
  },
  {
    iconBg: 'bg-orange-50 text-orange-600',
    icon: '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path></svg>',
    title: '复杂性区域识别',
    description: '基于多方法分歧度自动识别组织边界与过渡态区域，辅助生物学发现。'
  },
  {
    iconBg: 'bg-pink-50 text-pink-600',
    icon: '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4 4m0 0l-4-4m4 4V4"></path></svg>',
    title: '数据上传与管理',
    description: '支持自定义数据集上传，灵活配置实验参数，构建私有基准测试库。'
  },
  {
    iconBg: 'bg-indigo-50 text-indigo-600',
    icon: '<svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>',
    title: '详细教程指南',
    description: '提供完整的操作手册与指标解释，帮助研究人员快速上手并深入理解结果。'
  }
]

const loadStats = async () => {
  try {
    const response = await api.getStats()
    stats.value = response.data
  } catch (error) {
    console.error('加载统计数据失败:', error)
  }
}

onMounted(() => {
  loadStats()
})
</script>

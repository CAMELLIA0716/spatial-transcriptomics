<template>
  <aside class="w-56 bg-gradient-to-b from-slate-900 to-slate-800 text-white flex flex-col shadow-2xl z-30">
    <div class="p-5 border-b border-slate-700/50">
      <div class="flex items-center space-x-2">
        <div class="w-8 h-8 rounded-lg bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center shadow-lg shadow-blue-500/30">
          <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19.428 15.428a2 2 0 00-1.022-.547l-2.387-.477a6 6 0 00-3.86.517l-.318.158a6 6 0 01-3.86.517L6.05 15.21a2 2 0 00-1.806.547M8 4h8l-1 1v5.172a2 2 0 00.586 1.414l5 5c1.26 1.26.367 3.414-1.415 3.414H4.828c-1.782 0-2.674-2.154-1.414-3.414l5-5A2 2 0 009 10.172V5L8 4z"></path>
          </svg>
        </div>
        <div>
          <h1 class="text-sm font-bold tracking-wide text-blue-300">空间转录组</h1>
          <p class="text-xs text-slate-400">可视化分析平台</p>
        </div>
      </div>
    </div>

    <nav class="flex-1 py-4">
      <a
          href="#"
          v-for="item in navItems"
          :key="item.id"
          @click.prevent="$emit('tab-change', item.id)"
          :class="[
          'sidebar-link flex items-center px-4 py-3 text-sm',
          activeTab === item.id ? 'active' : 'text-slate-300'
        ]"
      >
        <svg class="w-4 h-4 mr-3 text-blue-400" fill="none" stroke="currentColor" v-html="item.icon"></svg>
        {{ item.label }}
      </a>
    </nav>

    <div class="p-4 border-t border-slate-700/50">
      <div class="bg-slate-800/50 rounded-lg p-3 backdrop-blur-sm">
        <p class="text-xs text-slate-400">版本</p>
        <p class="text-xs text-blue-300 font-mono">v3.3.0</p>
      </div>
    </div>
  </aside>
</template>

<script setup>
defineProps({
  activeTab: String
})
defineEmits(['tab-change'])

const navItems = [
  {
    id: 'overview',
    label: '概览',
    icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z"></path>'
  },
  {
    id: 'analysis',
    label: '数据分析',
    icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>'
  },
  {
    id: 'difference',
    label: '差异性分析',
    icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7h12m0 0l-4-4m4 4l-4 4m0 6H4m0 0l4 4m-4-4l4-4"></path>'
  },
  {
    id: 'about',
    label: '关于教程',
    icon: '<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>'
  }
]
</script>

<style scoped>
.sidebar-link {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  border-radius: 8px;
  margin: 4px 12px;
}
.sidebar-link:hover {
  background: linear-gradient(90deg, rgba(59, 130, 246, 0.15) 0%, transparent 100%);
  transform: translateX(4px);
}
.sidebar-link.active {
  background: linear-gradient(90deg, rgba(59, 130, 246, 0.25) 0%, rgba(59, 130, 246, 0.05) 100%);
  border-left: 3px solid #3b82f6;
  color: #1e40af;
  font-weight: 600;
}
</style>

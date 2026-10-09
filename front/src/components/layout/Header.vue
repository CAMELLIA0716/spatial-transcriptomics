<template>
  <header class="bg-white/80 backdrop-blur-md shadow-sm sticky top-0 z-20 border-b border-slate-200/50">
    <div class="max-w-full mx-auto px-6 py-4 flex justify-between items-center">
      <div class="flex items-center space-x-4">
        <h2 class="text-xl font-bold text-slate-800">{{ pageTitle }}</h2>
        <button
            v-if="showBackBtn"
            @click="$emit('back')"
            class="flex items-center space-x-1 text-sm text-blue-600 hover:text-blue-800 transition-colors font-medium"
        >
          <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
          </svg>
          <span>返回数据集</span>
        </button>
      </div>

      <div class="flex items-center space-x-4">
        <div class="relative">
          <input
              type="text"
              placeholder="全局搜索..."
              class="w-64 pl-10 pr-4 py-2 text-sm border border-slate-200 rounded-lg focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition-all bg-white/50 backdrop-blur-sm"
          >
          <svg class="w-4 h-4 text-slate-400 absolute left-3 top-1/2 transform -translate-y-1/2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
        </div>

        <div class="flex items-center space-x-3 pl-4 border-l border-slate-200">
          <div class="text-right">
            <p class="text-sm font-medium text-slate-700">研究员</p>
            <p class="text-xs text-slate-500">在线</p>
          </div>
          <div class="h-10 w-10 rounded-full bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center text-white font-bold shadow-lg ring-2 ring-white">
            R
          </div>
        </div>
      </div>
    </div>
  </header>
</template>

<script setup>
defineProps({
  pageTitle: String,
  showBackBtn: Boolean
})
defineEmits(['back'])
</script>

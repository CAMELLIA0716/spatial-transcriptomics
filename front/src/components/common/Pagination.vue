<template>
  <div class="flex items-center space-x-2" v-if="totalPages > 1">
    <button
        @click="$emit('page-change', currentPage - 1)"
        :disabled="currentPage === 1"
        class="pagination-btn px-3 py-1.5 text-sm rounded-lg border border-slate-200 bg-white text-slate-600 disabled:opacity-50 disabled:cursor-not-allowed"
    >
      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"></path>
      </svg>
    </button>

    <template v-for="page in visiblePages" :key="page">
      <button
          v-if="page !== '...'"
          @click="$emit('page-change', page)"
          :class="[
          'pagination-btn px-3 py-1.5 text-sm rounded-lg',
          page === currentPage
            ? 'bg-blue-600 text-white border-blue-600 shadow-sm'
            : 'border border-slate-200 bg-white text-slate-600 hover:bg-slate-50'
        ]"
      >
        {{ page }}
      </button>
      <span v-else class="px-2 text-slate-400">...</span>
    </template>

    <button
        @click="$emit('page-change', currentPage + 1)"
        :disabled="currentPage === totalPages"
        class="pagination-btn px-3 py-1.5 text-sm rounded-lg border border-slate-200 bg-white text-slate-600 disabled:opacity-50 disabled:cursor-not-allowed"
    >
      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7"></path>
      </svg>
    </button>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  currentPage: Number,
  totalPages: Number
})
defineEmits(['page-change'])

const visiblePages = computed(() => {
  const pages = []
  const delta = 1
  for (let i = 1; i <= props.totalPages; i++) {
    if (i === 1 || i === props.totalPages || (i >= props.currentPage - delta && i <= props.currentPage + delta)) {
      pages.push(i)
    } else if (pages[pages.length - 1] !== '...') {
      pages.push('...')
    }
  }
  return pages
})
</script>

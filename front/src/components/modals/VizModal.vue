<template>
  <div v-if="isOpen" class="fixed inset-0 z-50" @click.self="close">
    <div class="flex items-center justify-center min-h-screen">
      <div class="fixed inset-0 bg-black/50" @click="close"></div>
      <div class="bg-white rounded-lg p-6 z-10 max-w-4xl w-full max-h-[90vh] overflow-auto">
        <div class="flex justify-between items-center mb-4">
          <div>
            <h3 class="text-xl font-bold">{{ title }}</h3>
            <p class="text-sm text-slate-500">{{ subtitle }}</p>
          </div>
          <button @click="close" class="text-gray-500 hover:text-gray-700 text-2xl">&times;</button>
        </div>
        <div class="text-center">
          <img :src="imageUrl" alt="Visualization" class="max-w-full max-h-[70vh] mx-auto">
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import api from '../../api'

const isOpen = ref(false)
const title = ref('')
const subtitle = ref('')
const imageUrl = ref('')

const open = (type, method, dataId) => {
  title.value = type
  subtitle.value = `Method: ${method}`
  if (type === '空间表征图') {
    imageUrl.value = api.getOriginalPlotUrl(dataId, method)
  } else {
    imageUrl.value = api.getComplexPlotUrl(dataId, method)
  }
  isOpen.value = true
}

const close = () => {
  isOpen.value = false
}

defineExpose({ open })
</script>

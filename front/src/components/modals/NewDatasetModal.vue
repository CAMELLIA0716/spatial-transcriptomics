<template>
  <div v-if="isOpen" class="fixed inset-0 z-50" role="dialog" aria-modal="true">
    <div class="flex items-center justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
      <div class="fixed inset-0 modal-overlay transition-opacity" aria-hidden="true" @click="close"></div>
      <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

      <div class="inline-block align-bottom bg-white rounded-2xl text-left overflow-hidden shadow-2xl transform transition-all sm:my-8 sm:align-middle sm:max-w-2xl sm:w-full">
        <div class="bg-white px-6 pt-6 pb-4">
          <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-semibold text-slate-800">新建数据集</h3>
            <button @click="close" class="text-slate-400 hover:text-slate-600 transition-colors">
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
              </svg>
            </button>
          </div>

          <form @submit.prevent="submit" class="space-y-4">
            <div class="grid grid-cols-2 gap-4">
              <div>
                <label class="block text-sm font-medium text-slate-700">样本ID (data_id)</label>
                <input type="text" required v-model="form.dataId" class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
              </div>

              <div>
                <label class="block text-sm font-medium text-slate-700">方法</label>
                <select v-model="form.methodId" required class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
                  <option v-for="m in methods" :key="m.id" :value="m.id">{{ m.name }}</option>
                </select>
              </div>

              <div>
                <label class="block text-sm font-medium text-slate-700">Technology</label>
                <input type="text" v-model="form.technology" class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
              </div>

              <div>
                <label class="block text-sm font-medium text-slate-700">Size</label>
                <input type="text" v-model="form.size" class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
              </div>

              <div>
                <label class="block text-sm font-medium text-slate-700">Spots</label>
                <input type="number" v-model.number="form.spots" class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
              </div>

              <div>
                <label class="block text-sm font-medium text-slate-700">Genes</label>
                <input type="number" v-model.number="form.genes" class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
              </div>

              <div>
                <label class="block text-sm font-medium text-slate-700">Sparsity</label>
                <input type="text" v-model="form.sparsity" class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
              </div>

              <div>
                <label class="block text-sm font-medium text-slate-700">Type</label>
                <select v-model="form.type" class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
                  <option value="home">home</option>
                  <option value="nonTypical">nonTypical</option>
                </select>
              </div>

              <div class="col-span-2">
                <label class="block text-sm font-medium text-slate-700">Annotation</label>
                <input type="text" v-model="form.annotation" class="mt-1 block w-full rounded-md border-slate-300 shadow-sm focus:border-blue-500 focus:ring-blue-500 sm:text-sm border p-2">
              </div>

              <div class="col-span-2">
                <label class="block text-sm font-medium text-slate-700">Upload File</label>
                <div class="mt-1 flex justify-center px-6 pt-5 pb-6 border-2 border-slate-300 border-dashed rounded-md hover:bg-slate-50 transition-colors cursor-pointer">
                  <div class="space-y-1 text-center">
                    <svg class="mx-auto h-12 w-12 text-slate-400" stroke="currentColor" fill="none" viewBox="0 0 48 48">
                      <path d="M28 8H12a4 4 0 00-4 4v20m32-12v8m0 0v8a4 4 0 01-4 4H12a4 4 0 01-4-4v-4m32-4l-3.172-3.172a4 4 0 00-5.656 0L28 28M8 32l9.172-9.172a4 4 0 015.656 0L28 28m0 0l4 4m4-24h8m-4-4v8m-12 4h.02" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                    </svg>
                    <div class="flex text-sm text-slate-600 justify-center">
                      <label class="relative cursor-pointer bg-white rounded-md font-medium text-blue-600 hover:text-blue-500 focus-within:outline-none">
                        <span>上传文件</span>
                        <input type="file" class="sr-only" @change="handleFileUpload">
                      </label>
                      <p class="pl-1">或拖拽至此</p>
                    </div>
                    <p class="text-xs text-slate-500">支持 CSV, H5AD, TXT 格式</p>
                  </div>
                </div>
              </div>
            </div>

            <div class="bg-gradient-to-r from-slate-50 to-white px-6 py-4 flex justify-end items-center border-t border-slate-200">
              <button type="button" class="btn-secondary px-5 py-2 text-sm font-medium text-slate-700 rounded-lg mr-3" @click="close">
                取消
              </button>
              <button type="submit" class="btn-primary px-5 py-2 text-sm font-medium text-white rounded-lg">
                提交并上传
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive, onMounted, inject } from 'vue'

const api = inject('api')
const emit = defineEmits(['created'])
const isOpen = ref(false)
const methods = ref([])

const form = reactive({
  dataId: '',
  methodId: '',
  technology: '',
  size: '',
  spots: null,
  genes: null,
  sparsity: '',
  annotation: '',
  type: 'home',
  file: null
})

const open = async () => {
  // 加载方法列表
  const res = await api.getMethods?.() || { data: [] }
  methods.value = res.data
  isOpen.value = true
}

const close = () => {
  isOpen.value = false
  resetForm()
}

const resetForm = () => {
  form.dataId = ''
  form.methodId = ''
  form.technology = ''
  form.size = ''
  form.spots = null
  form.genes = null
  form.sparsity = ''
  form.annotation = ''
  form.type = 'home'
  form.file = null
}

const handleFileUpload = (event) => {
  form.file = event.target.files[0]
}

const submit = async () => {
  try {
    const formData = new FormData()
    formData.append('dataId', form.dataId)
    formData.append('methodId', form.methodId)
    formData.append('technology', form.technology || '')
    formData.append('size', form.size || '')
    formData.append('spots', form.spots || '')
    formData.append('genes', form.genes || '')
    formData.append('sparsity', form.sparsity || '')
    formData.append('annotation', form.annotation || '')
    formData.append('type', form.type)
    if (form.file) {
      formData.append('file', form.file)
    }

    await api.createDataset(formData)
    alert("数据集创建成功！")
    close()
    emit('created')
  } catch (error) {
    alert("创建失败: " + (error.response?.data?.message || error.message))
  }
}

defineExpose({ open })
</script>

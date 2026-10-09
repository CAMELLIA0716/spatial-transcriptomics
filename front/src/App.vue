<template>
  <div class="flex h-screen overflow-hidden text-slate-700">
    <Sidebar :activeTab="activeTab" @tab-change="handleTabChange" />

    <main class="flex-1 overflow-y-auto relative">
      <Header
          :pageTitle="pageTitle"
          :showBackBtn="showBackBtn"
          @back="goBack"
      />

      <div class="max-w-full mx-auto px-6 py-6">
        <Overview v-show="activeTab === 'overview'" />
        <Analysis
            v-show="activeTab === 'analysis'"
            @view-performance="goToPerformance"
        />
        <Performance
            v-show="activeTab === 'performance'"
            :dataId="currentDataId"
        />
        <Difference v-show="activeTab === 'difference'" :dataId="currentDataIdForDiff" />
        <About v-show="activeTab === 'about'" />
      </div>
    </main>

    <NewDatasetModal ref="newDatasetModal" @created="handleDatasetCreated" />
    <VizModal ref="vizModal" />
  </div>
</template>

<script setup>
import { ref, computed, provide } from 'vue'
import Sidebar from './components/layout/Sidebar.vue'
import Header from './components/layout/Header.vue'
import Overview from './views/Overview.vue'
import Analysis from './views/Analysis.vue'
import Performance from './views/Performance.vue'
import Difference from './views/Difference.vue'
import About from './views/About.vue'
import NewDatasetModal from './components/modals/NewDatasetModal.vue'
import VizModal from './components/modals/VizModal.vue'
import api from './api'

const activeTab = ref('overview')
const currentDataId = ref(null)      // 当前选中的样本ID，用于性能页面
const currentDataIdForDiff = ref('151508') // 默认样本ID，用于差异分析

const showBackBtn = computed(() => activeTab.value === 'performance')

const pageTitle = computed(() => {
  const titles = {
    'overview': '平台概览',
    'analysis': '数据分析',
    'performance': '方法性能评估',
    'difference': '差异性分析',
    'about': '关于教程'
  }
  return titles[activeTab.value] || '平台概览'
})

const newDatasetModal = ref(null)
const vizModal = ref(null)

provide('api', api)  // 提供 api 给所有子组件

provide('modals', {
  openNewDatasetModal: () => newDatasetModal.value?.open(),
  openVizModal: (type, method, dataId) => {
    vizModal.value?.open(type, method, dataId)
  }
})

const handleTabChange = (tabId) => {
  activeTab.value = tabId
}

const goToPerformance = (dataId) => {
  currentDataId.value = dataId
  activeTab.value = 'performance'
}

const goBack = () => {
  activeTab.value = 'analysis'
}

const handleDatasetCreated = () => {
  // 刷新数据集列表
  if (activeTab.value === 'analysis') {
    // 可以通过事件通知 Analysis 组件刷新
  }
}
</script>

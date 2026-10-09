<template>
  <div class="fade-in">
    <div class="card p-8 max-w-4xl mx-auto shadow-sm">
      <h2 class="text-2xl font-bold text-slate-800 mb-6">平台教程与指南</h2>
      <div class="space-y-6 text-slate-600 leading-relaxed">
        <div class="border-l-4 border-blue-500 pl-4 bg-blue-50/50 py-3 rounded-r-lg">
          <h3 class="text-lg font-semibold text-slate-800 mb-2">1. 平台简介</h3>
          <p>空间转录组可视化分析平台旨在为研究人员提供一个全面、客观的基准测试环境，用于评估不同的空间转录组聚类和分析方法。本平台整合了多种公开数据集和主流算法，通过标准化的评估指标帮助用户选择最适合其研究需求的工具。</p>
        </div>

        <div class="border-l-4 border-purple-500 pl-4 bg-purple-50/50 py-3 rounded-r-lg">
          <h3 class="text-lg font-semibold text-slate-800 mb-2">2. 如何使用数据分析模块</h3>
          <ul class="list-disc pl-5 space-y-2">
            <li><strong>数据集列表:</strong> 在"Data Analysis"页面，您可以查看所有可用的空间转录组样本。</li>
            <li><strong>Performance:</strong> 点击任意样本的"Performance"按钮，将跳转到该样本的方法性能评估表格。</li>
            <li><strong>评估指标:</strong> 性能表格包含三大类指标：Accuracy (NMI, HOM, COM), Continuity (CHAOS, PAS, ASW), Marker Score (Moran'I, Geary's C)。</li>
            <li><strong>可视化:</strong> 点击 Visualizations 列下的按钮可以查看空间表征图和差异表征图。</li>
          </ul>
        </div>

        <div class="border-l-4 border-green-500 pl-4 bg-green-50/50 py-3 rounded-r-lg">
          <h3 class="text-lg font-semibold text-slate-800 mb-2">3. 评估指标说明</h3>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mt-3">
            <div class="bg-white p-3 rounded-lg border border-blue-100 shadow-sm">
              <p class="font-semibold text-blue-800">Accuracy</p>
              <p class="text-sm text-blue-600 mt-1">NMI, HOM, COM - 聚类准确性评估</p>
            </div>
            <div class="bg-white p-3 rounded-lg border border-green-100 shadow-sm">
              <p class="font-semibold text-green-800">Continuity</p>
              <p class="text-sm text-green-600 mt-1">CHAOS, PAS, ASW - 空间连续性评估</p>
            </div>
            <div class="bg-white p-3 rounded-lg border border-purple-100 shadow-sm">
              <p class="font-semibold text-purple-800">Marker Score</p>
              <p class="text-sm text-purple-600 mt-1">Moran'I, Geary's C - 空间自相关评估</p>
            </div>
          </div>
        </div>

        <div class="border-l-4 border-orange-500 pl-4 bg-orange-50/50 py-3 rounded-r-lg">
          <h3 class="text-lg font-semibold text-slate-800 mb-2">4. 差异性分析</h3>
          <p>差异性分析功能基于多方法的分歧度，识别那些不同方法给出不同聚类结果的 spot。点击可视化按钮可查看各方法对该 spot 的聚类结果。顶部的交互视图直观展示了复杂区域的空间分布。</p>
        </div>

        <div class="mt-8 p-5 bg-gradient-to-r from-blue-50 to-purple-50 rounded-xl border border-blue-200 shadow-sm">
          <div class="flex items-start space-x-3">
            <svg class="w-6 h-6 text-blue-600 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
            <div>
              <h4 class="text-blue-800 font-semibold">提示</h4>
              <p class="text-blue-700 text-sm mt-1">本平台数据仅供参考，实际实验结果可能因具体生物学背景而异。建议结合多种评估指标和生物学知识进行综合判断。</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

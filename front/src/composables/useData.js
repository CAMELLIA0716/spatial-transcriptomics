import { ref, computed } from 'vue'

// 数据集数据
const datasetData = {
    home: [
        { id: "D001", tech: "Visium", size: "6.5mm", spots: 4992, genes: 18000, sparsity: "0.85", annotation: "Human Brain" },
        { id: "D002", tech: "Stereo-seq", size: "13mm", spots: 12000, genes: 20000, sparsity: "0.78", annotation: "Mouse Brain" },
        { id: "D003", tech: "Visium", size: "6.5mm", spots: 5000, genes: 17500, sparsity: "0.82", annotation: "Human Liver" },
        { id: "D004", tech: "Slide-seqV2", size: "10mm", spots: 8500, genes: 15000, sparsity: "0.90", annotation: "Mouse Heart" },
        { id: "D005", tech: "Stereo-seq", size: "13mm", spots: 15000, genes: 22000, sparsity: "0.75", annotation: "Human Kidney" },
    ],
    nonTypical: [
        { id: "D006", tech: "Visium", size: "6.5mm", spots: 3500, genes: 12000, sparsity: "0.92", annotation: "Plant Root" },
        { id: "D007", tech: "Stereo-seq", size: "13mm", spots: 9000, genes: 16000, sparsity: "0.88", annotation: "Zebrafish" },
    ]
}

// 方法性能数据 (8种方法)
const performanceData = [
    { name: "STAIG", nmi: 0.78, hom: 0.80, com: 0.76, chaos: 0.69, pas: 0.86, asw: 0.70, moran: 0.83, geary: 0.76 },
    { name: "STAGATE", nmi: 0.71, hom: 0.74, com: 0.70, chaos: 0.72, pas: 0.82, asw: 0.65, moran: 0.79, geary: 0.73 },
    { name: "GraphST", nmi: 0.71, hom: 0.73, com: 0.69, chaos: 0.73, pas: 0.81, asw: 0.64, moran: 0.78, geary: 0.72 },
    { name: "DeepST", nmi: 0.66, hom: 0.69, com: 0.65, chaos: 0.75, pas: 0.79, asw: 0.62, moran: 0.75, geary: 0.69 },
    { name: "CCST", nmi: 0.65, hom: 0.68, com: 0.64, chaos: 0.76, pas: 0.78, asw: 0.61, moran: 0.74, geary: 0.68 },
    { name: "SpaGCN", nmi: 0.56, hom: 0.59, com: 0.55, chaos: 0.80, pas: 0.72, asw: 0.55, moran: 0.68, geary: 0.62 },
    { name: "conST", nmi: 0.48, hom: 0.51, com: 0.47, chaos: 0.82, pas: 0.69, asw: 0.52, moran: 0.65, geary: 0.59 },
    { name: "SpaceFlow", nmi: 0.48, hom: 0.50, com: 0.46, chaos: 0.83, pas: 0.68, asw: 0.51, moran: 0.64, geary: 0.58 },
]

// 准确率数据
const accuracyData = [
    { method: "ground_truth", score: 1.0000 },
    { method: "STAIG", score: 0.7818 },
    { method: "STAGATE", score: 0.7131 },
    { method: "GraphST", score: 0.7124 },
    { method: "DeepST", score: 0.6649 },
    { method: "CCST", score: 0.6594 },
    { method: "SpaGCN", score: 0.5643 },
    { method: "conST", score: 0.4885 },
    { method: "spaceflow", score: 0.4839 }
]

// 差异数据
const differenceData = [
    { spot_name: "S001", consistency: 0.92, level: "High", x: 120, y: 340 },
    { spot_name: "S002", consistency: 0.88, level: "High", x: 145, y: 367 },
    { spot_name: "S003", consistency: 0.85, level: "High", x: 123, y: 389 },
    { spot_name: "S004", consistency: 0.81, level: "Medium", x: 156, y: 412 },
    { spot_name: "S005", consistency: 0.78, level: "Medium", x: 178, y: 445 },
    { spot_name: "S006", consistency: 0.75, level: "Medium", x: 134, y: 456 },
    { spot_name: "S007", consistency: 0.72, level: "Medium", x: 167, y: 423 },
    { spot_name: "S008", consistency: 0.68, level: "Low", x: 189, y: 478 },
    { spot_name: "S009", consistency: 0.65, level: "Low", x: 112, y: 490 },
    { spot_name: "S010", consistency: 0.62, level: "Low", x: 145, y: 434 },
]

export function useData() {
    // 分页状态
    const datasetPage = ref(1)
    const datasetPageSize = ref(5)
    const perfPage = ref(1)
    const perfPageSize = ref(8)
    const currentSubtab = ref('home')

    // 获取值类 (用于性能表格高亮)
    const getValueClass = (val, isChaos = false) => {
        if (isChaos) return val <= 0.70 ? 'value-high' : val <= 0.75 ? 'value-mid' : 'value-low'
        return val >= 0.75 ? 'value-high' : val >= 0.65 ? 'value-mid' : 'value-low'
    }

    return {
        datasetData,
        performanceData,
        accuracyData,
        differenceData,
        datasetPage,
        datasetPageSize,
        perfPage,
        perfPageSize,
        currentSubtab,
        getValueClass
    }
}

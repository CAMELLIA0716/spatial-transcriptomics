import axios from 'axios'

const API_BASE = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/api'

const api = {
    // Dashboard
    getStats: () => axios.get(`${API_BASE}/dashboard/stats`),

    // Datasets
    getDatasets: (params) => axios.get(`${API_BASE}/datasets`, { params }),
    createDataset: (formData) => axios.post(`${API_BASE}/datasets`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
    }),

    // Performance (using dataId)
    getPerformance: (dataId, params) =>
        axios.get(`${API_BASE}/samples/${dataId}/performance`, { params }),
    getAccuracy: (dataId) =>
        axios.get(`${API_BASE}/samples/${dataId}/accuracy`),

    // Difference
    getDifferenceSpots: (dataId) =>
        axios.get(`${API_BASE}/samples/${dataId}/difference-spots`),

    // Files
    getOriginalPlotUrl: (dataId, methodName) =>
        `${API_BASE}/files/original/${dataId}/${methodName}`,
    getComplexPlotUrl: (dataId, methodName) =>
        `${API_BASE}/files/complex/${dataId}/${methodName}`,
    getDashboardUrl: (dataId) =>
        `${API_BASE}/files/dashboard/${dataId}`,
}

export default api

// Mock sensor data
const sensorData = {
    temperature: 24.5,
    humidity: 65,
    soilMoisture: 42,
    lightIntensity: 1200
};

// Update dashboard with sensor data
function updateDashboard() {
    // Update sensor values
    document.querySelectorAll('.sensor-value').forEach(el => {
        const sensorType = el.dataset.sensor;
        el.textContent = sensorData[sensorType] + (sensorType === 'temperature' ? '°C' : sensorType === 'lightIntensity' ? 'lux' : '%');
    });

    // Update farm health status
    updateHealthStatus();
    
    // Update alerts
    updateAlerts();
}

// Display alerts
function updateAlerts() {
    const alertsContainer = document.querySelector('.alerts-container');
    if (alertsContainer) {
        alertsContainer.innerHTML = '';
        
        const alerts = generateAlerts();
        
        if (alerts.length === 0) {
            alertsContainer.innerHTML = '<div class="no-alerts">No active alerts</div>';
        } else {
            alerts.forEach(alert => {
                const alertElement = document.createElement('div');
                alertElement.textContent = alert;
                alertsContainer.appendChild(alertElement);
            });
        }
    }
}

// Determine farm health status
function updateHealthStatus() {
    const healthIndicator = document.querySelector('.health-indicator .status');
    if (healthIndicator) {
        let status = 'good';
        let statusText = 'Good';

        if (sensorData.temperature > 30 || sensorData.temperature < 15) {
            status = 'warning';
            statusText = 'Warning';
        } else if (sensorData.soilMoisture < 30) {
            status = 'average';
            statusText = 'Needs Attention';
        }

        healthIndicator.className = status;
        healthIndicator.textContent = statusText;
    }
}

// Generate mock alerts
function generateAlerts() {
    const alerts = [];
    
    if (sensorData.temperature > 28) {
        alerts.push('High temperature detected - consider shade or ventilation');
    }
    if (sensorData.soilMoisture < 35) {
        alerts.push('Low soil moisture - irrigation recommended');
    }
    if (sensorData.humidity > 80) {
        alerts.push('High humidity - risk of mold');
    }

    return alerts;
}

// Initialize the app
document.addEventListener('DOMContentLoaded', () => {
    updateDashboard();
    
    // Simulate data changes every 5 seconds
    setInterval(() => {
        // Randomize sensor data slightly
        sensorData.temperature += (Math.random() - 0.5) * 2;
        sensorData.humidity += (Math.random() - 0.5) * 5;
        sensorData.soilMoisture += (Math.random() - 0.5) * 3;
        sensorData.lightIntensity += (Math.random() - 0.5) * 100;
        
        // Keep values within reasonable ranges
        sensorData.temperature = Math.max(10, Math.min(35, sensorData.temperature));
        sensorData.humidity = Math.max(30, Math.min(90, sensorData.humidity));
        sensorData.soilMoisture = Math.max(20, Math.min(80, sensorData.soilMoisture));
        sensorData.lightIntensity = Math.max(500, Math.min(2000, sensorData.lightIntensity));
        
        updateDashboard();
    }, 1000);
});

import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  const [isElectron, setIsElectron] = useState(false);
  const [counter, setCounter] = useState(0);

  useEffect(() => {
    // Check if running in Electron
    setIsElectron(window.electronAPI !== undefined);
  }, []);

  const handleOpenFile = async () => {
    if (window.electronAPI) {
      try {
        const result = await window.electronAPI.openFile();
        console.log('File opened:', result);
      } catch (error) {
        console.error('Error opening file:', error);
      }
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      {/* Header */}
      <header className="bg-white shadow-sm border-b border-gray-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-4">
            <div className="flex items-center space-x-4">
              <div className="w-8 h-8 bg-indigo-600 rounded-lg flex items-center justify-center">
                <span className="text-white font-bold text-sm">A</span>
              </div>
              <h1 className="text-xl font-semibold text-gray-900">
                Electron + React + Tailwind
              </h1>
            </div>
            <div className="flex items-center space-x-2">
              <span className={`px-2 py-1 text-xs font-medium rounded-full ${
                isElectron 
                  ? 'bg-green-100 text-green-800' 
                  : 'bg-orange-100 text-orange-800'
              }`}>
                {isElectron ? 'Electron' : 'Browser'}
              </span>
            </div>
          </div>
        </div>
      </header>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
          
          {/* Welcome Card */}
          <div className="bg-white rounded-xl shadow-lg p-6 border border-gray-200">
            <h2 className="text-2xl font-bold text-gray-900 mb-4">
              Welcome to Your App! 🚀
            </h2>
            <p className="text-gray-600 mb-6">
              This is a starter template with Electron, React, and Tailwind CSS. 
              You're ready to build amazing desktop applications!
            </p>
            
            <div className="space-y-4">
              <div className="flex items-center space-x-3">
                <div className="w-2 h-2 bg-green-500 rounded-full"></div>
                <span className="text-sm text-gray-700">React 18 with Hooks</span>
              </div>
              <div className="flex items-center space-x-3">
                <div className="w-2 h-2 bg-blue-500 rounded-full"></div>
                <span className="text-sm text-gray-700">Tailwind CSS for styling</span>
              </div>
              <div className="flex items-center space-x-3">
                <div className="w-2 h-2 bg-purple-500 rounded-full"></div>
                <span className="text-sm text-gray-700">Electron for desktop</span>
              </div>
            </div>
          </div>

          {/* Interactive Demo */}
          <div className="bg-white rounded-xl shadow-lg p-6 border border-gray-200">
            <h3 className="text-xl font-semibold text-gray-900 mb-4">
              Interactive Demo
            </h3>
            
            <div className="space-y-4">
              {/* Counter */}
              <div className="bg-gray-50 rounded-lg p-4">
                <div className="flex items-center justify-between mb-3">
                  <span className="text-sm font-medium text-gray-700">Counter:</span>
                  <span className="text-2xl font-bold text-indigo-600">{counter}</span>
                </div>
                <div className="flex space-x-2">
                  <button
                    onClick={() => setCounter(c => c - 1)}
                    className="px-3 py-1 bg-red-500 text-white rounded-md hover:bg-red-600 transition-colors text-sm"
                  >
                    -
                  </button>
                  <button
                    onClick={() => setCounter(0)}
                    className="px-3 py-1 bg-gray-500 text-white rounded-md hover:bg-gray-600 transition-colors text-sm"
                  >
                    Reset
                  </button>
                  <button
                    onClick={() => setCounter(c => c + 1)}
                    className="px-3 py-1 bg-green-500 text-white rounded-md hover:bg-green-600 transition-colors text-sm"
                  >
                    +
                  </button>
                </div>
              </div>

              {/* Electron Features */}
              {isElectron && (
                <div className="bg-indigo-50 rounded-lg p-4">
                  <h4 className="font-medium text-indigo-900 mb-2">Electron Features</h4>
                  <button
                    onClick={handleOpenFile}
                    className="w-full px-4 py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 transition-colors"
                  >
                    Open File Dialog
                  </button>
                </div>
              )}
            </div>
          </div>
        </div>

        {/* Getting Started */}
        <div className="mt-8 bg-white rounded-xl shadow-lg p-6 border border-gray-200">
          <h3 className="text-xl font-semibold text-gray-900 mb-4">
            Getting Started
          </h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div className="bg-gray-50 rounded-lg p-4">
              <h4 className="font-medium text-gray-900 mb-2">1. Development</h4>
              <p className="text-sm text-gray-600">
                Run <code className="bg-gray-200 px-1 rounded">npm run electron-dev</code> 
                to start both React and Electron in development mode.
              </p>
            </div>
            <div className="bg-gray-50 rounded-lg p-4">
              <h4 className="font-medium text-gray-900 mb-2">2. Build</h4>
              <p className="text-sm text-gray-600">
                Use <code className="bg-gray-200 px-1 rounded">npm run electron-pack</code> 
                to create a distributable version of your app.
              </p>
            </div>
            <div className="bg-gray-50 rounded-lg p-4">
              <h4 className="font-medium text-gray-900 mb-2">3. Customize</h4>
              <p className="text-sm text-gray-600">
                Edit the components, add your features, and style with Tailwind CSS.
              </p>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}

export default App;
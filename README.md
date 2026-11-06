# 企業級硬體效能評估與投資效益分析系統 (Hardware Evaluator Pro v2.6)

[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%2F%2011%20(x64)-blue.svg?style=flat-square)](https://github.com/Chun-Chieh-Chang/HardwareBenchmarker)
[![Architecture](https://img.shields.io/badge/Architecture-Native%20.NET%20Framework-green.svg?style=flat-square)](https://github.com/Chun-Chieh-Chang/HardwareBenchmarker)
[![File Size](https://img.shields.io/badge/Binary%20Size-~47%20KB%20(Single%20Portable)-orange.svg?style=flat-square)](https://github.com/Chun-Chieh-Chang/HardwareBenchmarker)
[![Build Status](https://img.shields.io/badge/CI%2FCD-Automated%20Build%20%26%20Validation-brightgreen.svg?style=flat-square)](https://github.com/Chun-Chieh-Chang/HardwareBenchmarker/actions)
[![License](https://img.shields.io/badge/License-MIT-purple.svg?style=flat-square)](LICENSE)

專為同仁向主管、IT 資訊中心或財務部門**申請設備升級與汰換更新**而量身打造的自動化評測軟體。本系統能夠在 15 秒內自動採樣硬體算力、監控多工滿載瓶頸、執行確定性當機與假死停頓量化診斷，並直接產出具備法律公文效力與簽核欄位的**決策層商務 HTML / PDF 評估報告**。

---

## 🌟 核心價值：填補「極客跑分」與「商業決策」的溝通斷層

市面上絕大多數評測工具（如 Cinebench, Geekbench, UserBenchmark）本質皆為「硬體發燒友或遊戲玩家視角」，產出的是非技術主管看不懂的抽象跑分（如 9,500 分），且無法證明當機與卡頓是否肇因於硬體不足。

**Hardware Evaluator Pro 採用「企業決策層與財務簽核視角」**：
1. **業務語言轉譯**：直接將算力落差換算為「同仁每日卡頓等待分鐘數」與「年度沉沒工時損失（折合 USD 財務浪費）」，以客觀投資回報率（ROI）說服管理層。
2. **客觀責任歸屬判定**：透過「現代日常標準工作集合規審查」，科學證明在日常辦公與開發流程下，基礎開銷（15.7GB~22.5GB）即已超越舊設備實體天花板，徹底破除主管「是不是你自己開太多分頁」的質疑。
3. **免特權與零外部依賴**：完全無需 Python、Node.js 或任何套件，單一 47 KB 獨立執行檔，免管理員權限，100% 離線可用。

---

## 🚀 軟體亮點

### 1. 純獨立 Windows 原生可執行檔 (.exe)
- 採用 Windows 原生 .NET 編譯器（`csc.exe`）構建，極致輕量化（~47 KB）。
- 雙擊即可直接運行，零安全防毒誤判風險，無需提權（Non-Admin 友善）。

### 2. 15 秒全自動評測與向量遙測
- 無需任何參數配置，全自動探測 CPU、核心數、實體/虛擬記憶體、ACPI 電源架構（Modern Standby S0ix vs 傳統 S3）、以及 Linux/WSL2 協同開發環境。
- 自動執行單核心數學密集運算與全核心 100% 滿載壓力測試，採樣純向量 SVG 負載曲線。

### 3. 確定性當機、崩潰與停頓假死量化規則庫 (Deterministic Rule Engine)
依據計算機底層架構第一性原理，將故障機理結構化為 4 大客觀量化規則：

| 規則代碼 | 規則名稱 | 核心量化指標與判定公式 | 系統防禦與潛在錯誤代碼 |
| :--- | :--- | :--- | :--- |
| **Rule 1** | **記憶體枯竭與分頁檔風暴**<br/>(RAM Exhaustion & Thrashing) | **記憶體壓力赤字 (MPDR)**：<br/>$\text{MPDR} = \max\left(0, \frac{\text{Workload} - \text{TotalRAM}}{\text{Workload}}\right) \times 100\%$ | 硬性分頁錯誤（Hard Faults $> 1,200\text{/s}$），磁碟 I/O $100\%$ 卡死，觸發介面假死（DWM Hang）與進程崩潰（`0xC0000005 OOM`）。 |
| **Rule 2** | **熱過載降頻與斷電保護**<br/>(Thermal Saturation & PROCHOT) | **熱降頻衰減率 (TPTR)**：<br/>$\text{TPTR} = \max\left(0, \frac{\text{Expected} - \text{Actual}}{\text{Expected}}\right) \times 100\%$ | 長時間滿載觸發 Intel/AMD **PROCHOT** 時脈驟降（$4.2\text{GHz} \rightarrow 0.8\text{GHz}$ 投影片式卡頓）；達 $105^\circ\text{C}$ ($T_{\text{junction}}$) 觸發硬體熱保護斷電重啟（`Kernel-Power 41`）。 |
| **Rule 3** | **Modern Standby 睡眠死機**<br/>(S0ix Thermal Sleep Crash) | **密閉空間熱阻係數**：$\ge 3.5\text{ K/W}$<br/>**連線待命背景功耗**：$3.0\text{W} \sim 6.0\text{W}$ | 筆電 S0ix 闔蓋置入公事包通勤，密閉高溫悶燒；睡眠狀態轉換超時引發藍屏死機（`0x0000009F DRIVER_POWER_STATE_FAILURE`）。 |
| **Rule 4** | **磁碟佇列與 DPC 看門狗藍屏**<br/>(I/O Queue Saturation & Watchdog) | **SSD 佇列深度**：$> 32$<br/>**單次 I/O 延遲**：$> 3,500\text{ms}$ | 實體 RAM 不足迫使頻繁衝刷分頁檔，無 DRAM 快取之 SSD 延遲飆升，觸發核心看門狗藍屏（`0x00000133 DPC_WATCHDOG_VIOLATION`）。 |

### 4. 真實應用軟體核心負載模擬 (Microsoft Edge Headless Engine)
- 在**完全不彈出視窗、不搶奪滑鼠、零資安防毒誤判**的前提下，受控調用 Windows 原生 Microsoft Edge 核心進程。
- 背景動態生成包含 5,000 個 DOM 節點增刪、數值計算與樣式重繪之真實 Web 負載。
- 精準測量瀏覽器進程冷啟動延遲（ms）與 DOM 腳本解析耗時，真實反映同仁操作 ERP, CRM, Jira, Google Docs 等大型雲端系統時的真實流暢度。

### 5. 現代標準日常工作集 (Working Set) 合規性定量審查
報告內建 2025/2026 企業標準上班工作流之資源開銷清冊：
- **網頁與雲端協作**：Chrome / Edge (20~30 分頁，含 ERP, CRM, Docs, Jira) $\rightarrow$ **4.2 ~ 6.5 GB**
- **通訊與視訊會議**：Teams / Zoom 視訊 + 螢幕簡報分享 + Slack/Outlook $\rightarrow$ **2.4 ~ 3.5 GB**
- **專業生產力與檔案**：Excel 萬列報表 / VS Code / IntelliJ / Adobe Acrobat $\rightarrow$ **3.5 ~ 8.0 GB**
- **資安與常駐服務**：公司 EDR (CrowdStrike/Defender), 備份, Windows 索引 $\rightarrow$ **1.8 ~ 4.0 GB**
- $\Rightarrow$ **日常標準工作集總額**：**15.7 GB ~ 22.5 GB RAM**（證明當機非人為不當操作）。

### 5. 一鍵輸出高質感簽核報告
- 自動生成符合 Design Tokens 色彩大師規範之獨立 HTML 檔案（無外部 CDN 依賴，100% 離線渲染）。
- 內建 `@media print` 樣式優化，點擊「🖨️ 列印 / 另存為簽核 PDF」即可產出標準 A4 紙本或電子簽核公文，文末具備申請人、IT 主管與部門主管核決簽署欄位。

---

## 📁 專案目錄結構

```text
HardwareBenchmarker/
├── .github/
│   └── workflows/
│       └── ci.yml                       # GitHub Actions 原生編譯、確效與 Pages 自動化部署
├── dist/
│   ├── HardwareBenchmarker_Portable.exe # 【單一可攜式執行檔】（單拷此檔至隨身碟或桌面即可雙擊運行）
│   └── Hardware_Evaluation_Report.html   # 最新評估示範報告
├── HardwareBenchmarker_Portable.exe     # 根目錄編譯執行檔
├── HardwareBenchmarker.cs               # C# 原生原始碼（含 Assembly 元資料資訊與確定性規則推論引擎）
├── Hardware_Evaluation_Report.html      # 本機最新生成的正式評估報告
├── run.bat                              # 一鍵啟動批次檔
├── build.bat                            # 原生一鍵重新編譯腳本
├── DEV_LOG.md                           # 開發日誌與 RCA / CAPA 紀錄
└── README.md                            # 本技術與商務手冊
```

---

## 🚀 快速上手使用指引

### 方式 A：終端使用者（單檔攜帶即用）
1. 至 [`dist/HardwareBenchmarker_Portable.exe`](dist/HardwareBenchmarker_Portable.exe) 下載單一執行檔。
2. 複製到任何 Windows 10/11 電腦的桌面或隨身碟上。
3. **直接雙擊運行**（無需任何管理員權限）。
4. 靜候 15 秒，系統全自動完成評測並彈出正式評估報告 `Hardware_Evaluation_Report.html`。
5. 點擊右上角「🖨️ 列印 / 另存為簽核 PDF」，呈送主管簽核！

### 方式 B：開發者重新構建
本專案採用 Windows 內建之 C# 編譯器，完全無需安裝 Visual Studio 或 .NET SDK：
```cmd
build.bat
```
腳本將自動調用 `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe` 進行最佳化編譯，並自動同步至 `dist/` 目錄。

---

## ⚙️ CI/CD 與自動化部署

本專案配置了 GitHub Actions 自動化管線（`.github/workflows/ci.yml`）：
1. **Windows 虛擬機自動編譯**：在 `windows-latest` 執行環境透過原生 `csc.exe` 構建執行檔。
2. **Headless 無人值守確效**：於 CI 流程自動執行評測，斷言輸出報告之存在性與內容完整性。
3. **構建成品發布**：自動打包可執行檔與 HTML 報告為 Actions Artifacts。
4. **GitHub Pages 即時預覽**：自動將最新報告發布至 GitHub Pages 供線上即時查閱。

---

## 📄 授權條款 (License)

本專案採用 [MIT License](LICENSE) 授權發布，歡迎企業與個人自由分發與使用。

# Freally Central — UI strings (zh-CN)
# Keys must stay in sync across all locales (npm run i18n:lint).

app-name = Freally Central
app-tagline = 集中管理每一款 Freally 应用。
search-placeholder = 搜索应用…
filter-type = 类型
filter-all = 全部
available = 可用
coming-soon = 即将推出
download-all = 全部下载
download-all-hint = 下载功能将在后续更新中提供。
language = 语言
theme-toggle = 切换主题
card-view = 查看
detail-back = 返回
detail-features = 功能
detail-started = 始于 { $date }
detail-visit-site = 访问网站
detail-no-features = 功能详情即将公布。
detail-coming-soon-note = 此应用暂时无法下载。
status-loading = 正在加载目录…
status-offline = 离线 — 显示内置目录。
grid-empty = 没有匹配的应用。
eula-title = 最终用户许可协议
eula-intro = 请阅读并接受许可协议以继续。
eula-accept = 接受并继续
eula-decline = 拒绝
eula-scroll-hint = 滚动到底部以启用“接受”。
footer-note = 本地优先 · 无账户 · 无遥测

# --- Settings / About / What's New / Updates panels ---
settings-title = 设置
settings-theme = 主题
settings-theme-light = 浅色
settings-theme-dark = 深色
settings-check-updates = 检查更新
about-title = 关于
about-version = 版本
about-created-by = 开发者
about-project-started = 项目开始
about-first-stable = 首个稳定版
about-first-stable-pending = 尚未发布
about-platform = 平台
about-local-first = 本地优先且透明 — 无账户，无遥测。
about-website = 网站
about-issues = 报告问题
about-license = 许可证
about-eula = EULA
whats-new-title = 新功能
whats-new-loading = 正在加载版本说明…
whats-new-version = 版本 { $version } 的新功能
whats-new-empty = 此版本没有版本说明。
updates-title = 更新
updates-checking = 正在检查更新…
updates-uptodate = 已是最新版本。
updates-check-again = 再次检查
updates-available = 有可用版本 { $version }。
updates-current-version = (当前 { $current })
updates-release-notes-label = { $version } 的版本说明
updates-confirm = 立即下载并安装？
updates-yes-update-now = 立即更新
updates-no-not-now = 暂不
updates-downloading = 正在下载 { $version }
updates-starting = 正在开始…
updates-installed = 更新已安装。
updates-restart-now = 立即重启
updates-restart-later = 稍后
updates-try-again = 重试

# --- Live release data (Phase 2) ---
downloads-count = { $count } 次下载
downloads-total = 总计
downloads-brandwide = Freally 应用已被下载 { $count } 次
downloads-unavailable = 下载次数暂时不可用。
detail-released = 发布于 { $date }
detail-downloads = 下载
detail-whats-new = 新变化
refresh = 刷新
changelog-heading = { $name } 的新变化
changelog-version = 版本 { $version } · { $date }
changelog-empty = 暂无发行说明。
changelog-view-full = 查看完整更新日志
changelog-view-release = 在 GitHub 上查看

# --- Per-app taglines (localized catalog copy) ---
card-download = 下载
tagline-freally-capture = 像录音棚一样录制与直播 — 一个简洁的应用。
tagline-freally-vault = 你的密码、通行密钥与机密 — 加密、本地优先、属于你。
tagline-freally-player = 什么都能播放。优雅流畅。无广告、无间谍软件。
tagline-freally-av = Freally Anti-Virus — 即将推出。
tagline-freally-studio = AI 辅助的音乐工作室 — 即将推出。
tagline-freally-sourcerer = 即将推出的 Freally 应用。
tagline-freally-file-manager = 跨平台文件管理器 — 即将推出。

# --- Per-app descriptions & features (localized catalog copy) ---
desc-freally-capture = 本地优先、跨平台的直播与录制工作室（OBS 级）：实时 GPU 场景合成器、多轨录制，并可同时向所有平台多路推流 — 全部在你的设备上完成。无账户、无遥测、无云端。
desc-freally-vault = 本地优先、零知识、端到端加密的密码、通行密钥与机密管理器。兼容 KeePass，内存安全的 Rust 内核，完全免费 — 你的保险库永不离开你的设备。
desc-freally-player = 本地优先、跨平台的媒体播放器，借助硬件加速几乎什么都能播放 — 现代界面、真正的媒体库和流媒体，无广告、无遥测。
desc-freally-av = Freally 面向 Windows、macOS 和 Linux 的本地优先杀毒软件。开发中 — 暂时无法下载。
desc-freally-studio = 一款功能齐全的 DAW，支持 35+ 种风格的 AI 编曲生成、FL 风格混音器、编排时间线和音频剪辑编辑器。预发布 — 暂时无法下载。
desc-freally-sourcerer = 这款 Freally 应用正在开发中。暂时无法下载。
desc-freally-file-manager = 这款 Freally 应用正在开发中。暂时无法下载。
feat-freally-capture-1 = 自研 wgpu GPU 场景合成器，支持逐源滤镜与转场
feat-freally-capture-2 = 多轨录制（硬件编码器 + 自研无损编解码器）
feat-freally-capture-3 = 同时向 Twitch/YouTube/Kick 多路推流（RTMP/SRT/WHIP）
feat-freally-capture-4 = 虚拟摄像头、回放缓冲、下游键控和 3D 变换
feat-freally-capture-5 = 18 种语言界面

# --- Install status & actions (Phase 3) ---
status-installed = 已安装
status-update = 有可用更新
status-not-installed = 未安装
action-install = 安装
action-update = 更新
action-redownload = 重新下载

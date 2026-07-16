mod commands;
mod detect;
mod download;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .plugin(tauri_plugin_updater::Builder::new().build())
        .plugin(tauri_plugin_process::init())
        .manage(download::Downloads::default())
        .invoke_handler(tauri::generate_handler![
            commands::build_info,
            commands::release_notes,
            detect::detect_installed,
            download::start_download,
            download::cancel_download
        ])
        .run(tauri::generate_context!())
        .expect("error while running Freally Central");
}

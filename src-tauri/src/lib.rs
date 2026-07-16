mod commands;
mod detect;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .plugin(tauri_plugin_updater::Builder::new().build())
        .plugin(tauri_plugin_process::init())
        .invoke_handler(tauri::generate_handler![
            commands::build_info,
            commands::release_notes,
            detect::detect_installed
        ])
        .run(tauri::generate_context!())
        .expect("error while running Freally Central");
}

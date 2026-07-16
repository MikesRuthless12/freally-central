mod commands;
mod detect;
mod download;
mod install;

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .plugin(tauri_plugin_updater::Builder::new().build())
        .plugin(tauri_plugin_process::init())
        .manage(download::Downloads::default())
        .manage(download::VerifiedDownloads::default())
        .manage(install::Installs::default())
        .invoke_handler(tauri::generate_handler![
            commands::build_info,
            commands::release_notes,
            detect::detect_installed,
            download::start_download,
            download::cancel_download,
            install::install_apps,
            install::cancel_installs,
            install::launch_app
        ])
        .run(tauri::generate_context!())
        .expect("error while running Freally Central");
}

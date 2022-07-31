package com.jhatfat;

import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;

public class ApplicationStatus extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {

    @Override
    public void onCreate() {
        super.onCreate();
        FirebaseOptions options = new FirebaseOptions.Builder()
                .setApplicationId("com.jhatfat") // Required for Analytics.
                .setProjectId("jhatfat") // Required for Firebase Installations.
                .setApiKey("AIzaSyCTsuo3QSNdQmKWM3KUGQpYo-BrSWvNRjQ") // Required for Auth.
                .build();
        FirebaseApp.initializeApp(this,options,"jhatfat");
        
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    @Override
    public void registerWith(PluginRegistry registry) {
        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
    }
}

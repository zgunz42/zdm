-keep class androidx.lifecycle.** { *; }
#Flutter Wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String); 
}
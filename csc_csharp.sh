
#!/bin/bash
echo "*** 通过csc 进行C#项目编译 ***"
echo "Desc : 定点检查工具 项目工程解耦检查工具"
echo "Author : gengkun123@gmail.com"
echo "*** Run time: $(date) @ $(hostname)"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "DIR=$DIR"


csc="/Library/Frameworks/Mono.framework/Versions/Current/Commands/csc"

#DIR_PRO="/Users/kevin/elex/cod/cod_project/Client/Unity"
DIR_PRO="$DIR/../../Client/Unity"
DIR_ASSETS=$DIR_PRO/Assets


# # pwd
# ls $DIR_PRO
# echo "===="

# ls -d $DIR_PRO/**/Editor
# echo "----"
# EDITOR_ARR=`ls -d **/Editor`
# echo "$EDITOR_ARR"
# exit 

REV_DIR=("View" "ModelView" "Model")
TMP_DIR=$DIR_PRO/../tmp

if [[ -d $TMP_DIR ]]; then
	rm -rf $TMP_DIR
fi

mkdir $TMP_DIR


cd $DIR_PRO

EDITOR_ARR=`find . -name "Editor" | xargs rm -rf `
#echo "$Editor==="


FILE_DLL="${DIR_PRO}/tmp.dll"
rm -rf $FILE_DLL


DIR_SCRIPT=$DIR_ASSETS/CustomAssets/Scripts


#REF_DLL="/reference:/Applications/Unity/MonoDevelop.app/Contents/Frameworks/Mono.framework/Versions/Current/lib/mono/2.0/System.dll /reference:/Applications/Unity/MonoDevelop.app/Contents/Frameworks/Mono.framework/Versions/Current/lib/mono/2.0/System.Xml.dll /reference:/Applications/Unity/MonoDevelop.app/Contents/Frameworks/Mono.framework/Versions/Current/lib/mono/2.0/System.Runtime.Serialization.dll /reference:/Applications/Unity/MonoDevelop.app/Contents/Frameworks/Mono.framework/Versions/Current/lib/mono/2.0/System.Xml.Linq.dll /reference:/Applications/Unity/Unity.app/Contents/Managed/UnityEngine.dll /reference:/Applications/Unity/Unity.app/Contents/Managed/UnityEditor.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/GUISystem/UnityEngine.UI.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/Networking/UnityEngine.Networking.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/TestRunner/UnityEngine.TestRunner.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/TestRunner/net35/unity-custom/nunit.framework.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/Timeline/RuntimeEditor/UnityEngine.Timeline.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UIAutomation/UnityEngine.UIAutomation.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UnityGoogleAudioSpatializer/RuntimeEditor/UnityEngine.GoogleAudioSpatializer.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UnityHoloLens/RuntimeEditor/UnityEngine.HoloLens.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UnitySpatialTracking/RuntimeEditor/UnityEngine.SpatialTracking.dll /reference:${DIR_ASSETS}/3rd/DOTween/DOTween.dll /reference:${DIR_ASSETS}/3rd/DOTween/DOTween43.dll /reference:${DIR_ASSETS}/3rd/DOTween/DOTween46.dll /reference:${DIR_ASSETS}/3rd/DOTween/DOTween50.dll /reference:${DIR_ASSETS}/3rd/GZip/ICSharpCode.SharpZipLib.dll /reference:${DIR_ASSETS}/3rd/GZip/zlib.net.dll /reference:${DIR_ASSETS}/3rd/JsonDotNet/Examples/Tests/TestModels/SampleClassLibrary.dll /reference:${DIR_ASSETS}/Adjust/AdjustUnityWS10.dll /reference:${DIR_ASSETS}/Adjust/AdjustUnityWS81.dll /reference:${DIR_ASSETS}/CustomAssets/Plugins/HdgRemoteDebug/HdgRemoteDebugRuntime.dll /reference:${DIR_ASSETS}/Fabric/Managed/Analytics.dll /reference:${DIR_ASSETS}/Fabric/Managed/Validator.dll /reference:${DIR_ASSETS}/FacebookSDK/Plugins/Facebook.Unity.dll /reference:${DIR_ASSETS}/FacebookSDK/Plugins/Gameroom/Facebook.Unity.Gameroom.dll /reference:${DIR_ASSETS}/FacebookSDK/Plugins/Gameroom/FacebookNamedPipeClient.dll /reference:${DIR_ASSETS}/FacebookSDK/Plugins/Settings/Facebook.Unity.Settings.dll /reference:${DIR_ASSETS}/Firebase/Plugins/Firebase.Analytics.dll /reference:${DIR_ASSETS}/Firebase/Plugins/Firebase.App.dll /reference:${DIR_ASSETS}/Firebase/Plugins/Google.MiniJson.dll /reference:${DIR_ASSETS}/Parse/Plugins/Unity.Compat.dll /reference:${DIR_ASSETS}/Parse/Plugins/Unity.Tasks.dll /reference:/Users/kevin/Library/Unity/cache/packages/packages.unity.com/com.unity.analytics@1.0.1/UnityEngine.Analytics.dll /reference:/Users/kevin/Library/Unity/cache/packages/packages.unity.com/com.unity.purchasing@1.0.1/UnityEngine.Purchasing.dll /reference:/Applications/Unity/MonoDevelop.app/Contents/Frameworks/Mono.framework/Versions/Current/lib/mono/2.0/System.Core.dll /reference:/Users/kevin/elex/cod/cod_project/Client/Unity/Temp/bin/Debug//Assembly-CSharp-firstpass.dll /reference:/Applications/Unity/MonoDevelop.app/Contents/Frameworks/Mono.framework/Versions/Current/lib/mono/2.0/mscorlib.dll"
REF_DLL="/reference:/Applications/Unity/Unity.app/Contents/Managed/UnityEngine.dll /reference:/Applications/Unity/Unity.app/Contents/Managed/UnityEditor.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/GUISystem/UnityEngine.UI.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/GUISystem/Editor/UnityEditor.UI.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/Networking/UnityEngine.Networking.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/TestRunner/UnityEngine.TestRunner.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/TestRunner/net35/unity-custom/nunit.framework.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/Timeline/RuntimeEditor/UnityEngine.Timeline.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UIAutomation/UnityEngine.UIAutomation.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UnityGoogleAudioSpatializer/RuntimeEditor/UnityEngine.GoogleAudioSpatializer.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UnityHoloLens/RuntimeEditor/UnityEngine.HoloLens.dll /reference:/Applications/Unity/Unity.app/Contents/UnityExtensions/Unity/UnitySpatialTracking/RuntimeEditor/UnityEngine.SpatialTracking.dll /reference:${DIR_ASSETS}/3rd/DOTween/DOTween.dll /reference:${DIR_ASSETS}/3rd/DOTween/DOTween43.dll /reference:${DIR_ASSETS}/3rd/DOTween/DOTween46.dll /reference:${DIR_ASSETS}/3rd/DOTween/DOTween50.dll /reference:${DIR_ASSETS}/3rd/GZip/ICSharpCode.SharpZipLib.dll /reference:${DIR_ASSETS}/3rd/GZip/zlib.net.dll /reference:${DIR_ASSETS}/3rd/JsonDotNet/Examples/Tests/TestModels/SampleClassLibrary.dll /reference:${DIR_ASSETS}/Adjust/AdjustUnityWS10.dll /reference:${DIR_ASSETS}/Adjust/AdjustUnityWS81.dll /reference:${DIR_ASSETS}/CustomAssets/Plugins/HdgRemoteDebug/HdgRemoteDebugRuntime.dll /reference:${DIR_ASSETS}/Fabric/Managed/Analytics.dll /reference:${DIR_ASSETS}/Fabric/Managed/Validator.dll /reference:${DIR_ASSETS}/FacebookSDK/Plugins/Facebook.Unity.dll /reference:${DIR_ASSETS}/FacebookSDK/Plugins/Gameroom/Facebook.Unity.Gameroom.dll /reference:${DIR_ASSETS}/FacebookSDK/Plugins/Gameroom/FacebookNamedPipeClient.dll /reference:${DIR_ASSETS}/FacebookSDK/Plugins/Settings/Facebook.Unity.Settings.dll /reference:${DIR_ASSETS}/Firebase/Plugins/Firebase.Analytics.dll /reference:${DIR_ASSETS}/Firebase/Plugins/Firebase.App.dll /reference:${DIR_ASSETS}/Firebase/Plugins/Google.MiniJson.dll /reference:${DIR_ASSETS}/Parse/Plugins/Unity.Compat.dll /reference:${DIR_ASSETS}/Parse/Plugins/Unity.Tasks.dll"

DEFINE='/define:"DEBUG;TRACE;UNITY_5_3_OR_NEWER;UNITY_5_4_OR_NEWER;UNITY_5_5_OR_NEWER;UNITY_5_6_OR_NEWER;UNITY_2017_1_OR_NEWER;UNITY_2017_2_OR_NEWER;UNITY_2017_2_0;UNITY_2017_2;UNITY_2017;ENABLE_AUDIO;ENABLE_CACHING;ENABLE_CLOTH;ENABLE_GENERICS;ENABLE_PVR_GI;ENABLE_MICROPHONE;ENABLE_MULTIPLE_DISPLAYS;ENABLE_PHYSICS;ENABLE_SPRITERENDERER_FLIPPING;ENABLE_SPRITES;ENABLE_GRID;ENABLE_TILEMAP;ENABLE_TERRAIN;ENABLE_RAKNET;ENABLE_DIRECTOR;ENABLE_UNET;ENABLE_LZMA;ENABLE_UNITYEVENTS;ENABLE_WEBCAM;ENABLE_WWW;ENABLE_CLOUD_SERVICES_COLLAB;ENABLE_CLOUD_SERVICES_COLLAB_SOFTLOCKS;ENABLE_CLOUD_SERVICES_ADS;ENABLE_CLOUD_HUB;ENABLE_CLOUD_PROJECT_ID;ENABLE_CLOUD_SERVICES_USE_WEBREQUEST;ENABLE_CLOUD_SERVICES_UNET;ENABLE_CLOUD_SERVICES_BUILD;ENABLE_CLOUD_LICENSE;ENABLE_EDITOR_HUB;ENABLE_EDITOR_HUB_LICENSE;ENABLE_WEBSOCKET_CLIENT;ENABLE_DIRECTOR_AUDIO;ENABLE_TIMELINE;ENABLE_EDITOR_METRICS;ENABLE_EDITOR_METRICS_CACHING;ENABLE_NATIVE_ARRAY;ENABLE_SPRITE_MASKING;INCLUDE_DYNAMIC_GI;INCLUDE_GI;ENABLE_MONO_BDWGC;PLATFORM_SUPPORTS_MONO;INCLUDE_PUBNUB;ENABLE_PLAYMODE_TESTS_RUNNER;ENABLE_VIDEO;ENABLE_RMGUI;ENABLE_PACKMAN;ENABLE_CUSTOM_RENDER_TEXTURE;ENABLE_STYLE_SHEETS;PLATFORM_ANDROID;UNITY_ANDROID;UNITY_ANDROID_API;ENABLE_SUBSTANCE;ENABLE_EGL;ENABLE_NETWORK;ENABLE_RUNTIME_GI;ENABLE_CRUNCH_TEXTURE_COMPRESSION;ENABLE_UNITYWEBREQUEST;ENABLE_CLOUD_SERVICES;ENABLE_CLOUD_SERVICES_ANALYTICS;ENABLE_EVENT_QUEUE;ENABLE_CLOUD_SERVICES_PURCHASING;ENABLE_CLOUD_SERVICES_CRASH_REPORTING;ENABLE_CLOUD_SERVICES_NATIVE_CRASH_REPORTING;PLATFORM_SUPPORTS_ADS_ID;UNITY_CAN_SHOW_SPLASH_SCREEN;ENABLE_VR;ENABLE_AR;ENABLE_SPATIALTRACKING;ENABLE_UNITYADS_RUNTIME;UNITY_UNITYADS_API;ENABLE_MONO;NET_2_0_SUBSET;ENABLE_PROFILER;UNITY_ASSERTIONS;ENABLE_NATIVE_ARRAY_CHECKS;UNITY_TEAM_LICENSE;CROSS_PLATFORM_INPUT;MOBILE_INPUT;UNITY_HAS_GOOGLEVR;UNITY_HAS_TANGO"'
#echo $REF_DLL



echo "\n-----解耦检查开始-----\n"
#csc /nowarn:0169 /langversion:4  /warn:0 $DEFINE /target:library ${REF_DLL} /out:$FILE_DLL /recurse:${DIR_PRO}/*.cs #> $DIR_PRO/compiler.txt

 for i in ${REV_DIR[@]}; do
	
	echo "------移除${i}测试编译------"
	mv $DIR_SCRIPT/$i $TMP_DIR
	csc /nowarn:0169 /langversion:4  /warn:0 $DEFINE /target:library ${REF_DLL} /out:$FILE_DLL /recurse:${DIR_PRO}/*.cs #> $DIR_PRO/compiler.txt
	
done


for i in ${REV_DIR[@]}; do
	mv  $TMP_DIR/$i $DIR_SCRIPT
done


rm -rf $FILE_DLL

git checkout .

echo "Done!"


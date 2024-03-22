project "GLFW"
	kind "StaticLib"
	language "C"
	staticruntime "off"
	warnings "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		 "include/GLFW/glfw3.h",
         "include/GLFW/glfw3native.h",
	
         "src/internal.h", 
		 "src/platform.h",
		 "src/mappings.h",
         "src/context.c",
		 "src/init.c",
		 "src/input.c",
		 "src/monitor.c",
	 	 "src/platform.c", 
		 "src/vulkan.c",
		 "src/window.c",
         "src/egl_context.c",
		 "src/osmesa_context.c",
	
		 "src/null_platform.h",
		 "src/null_joystick.h",
         "src/null_init.c",
		 "src/null_monitor.c",
		 "src/null_window.c",
		 "src/null_joystick.c"
	}

	filter "system:linux"
		pic "On"

		systemversion "latest"
		if os.getenv("WAYLAND") then
			defines
			{
				"_GLFW_WAYLAND"
			}
	
			files
			{
				"src/posix_time.h",
				"src/posix_thread.h",
				"src/posix_module.c",
				"src/posix_time.c",
				"src/posix_thread.c",
				"src/wl_platform.h",
				"src/xkb_unicode.h",
				"src/wl_init.c",
	            "src/wl_monitor.c",
				"src/wl_window.c",
				"src/xkb_unicode.c",
				"src/linux_joystick.h",
				"src/linux_joystick.c"
			}
		else
			defines
			{
				"_GLFW_X11"
			}
			files
			{
				"src/posix_time.h",
				"src/posix_thread.h",
				"src/posix_module.c",
				"src/posix_time.c",
				"src/posix_thread.c",
				"src/x11_platform.h",
				"src/xkb_unicode.h", 
				"src/x11_init.c",
                "src/x11_monitor.c",
				"src/x11_window.c",
				"src/xkb_unicode.c",
                "src/glx_context.c",
				"src/linux_joystick.h",
				"src/linux_joystick.c"
			}
		end

	filter "system:macosx"
		pic "On"

		files
		{
			"src/cocoa_time.h",
			"src/cocoa_time.c",
			"src/posix_thread.h",
			"src/posix_module.c",
			"src/posix_thread.c",

			"src/cocoa_platform.h", 
			"src/cocoa_joystick.h",
			"src/cocoa_init.m",
	        "src/cocoa_joystick.m",
			"src/cocoa_monitor.m",
			"src/cocoa_window.m",
			"src/nsgl_context.m"
		}

		defines
		{
			"_GLFW_COCOA"
		}

	filter "system:windows"
		systemversion "latest"

		files
		{
			"src/win32_platform.h", 
			"src/win32_joystick.h", 
			"src/win32_init.c",
            "src/win32_joystick.c", 
			"src/win32_monitor.c", 
			"src/win32_window.c",
            "src/wgl_context.c",
			"src/win32_time.h", 
			"src/win32_thread.h",
			"src/win32_module.c",
			"src/win32_time.c",
			"src/win32_thread.c"
		}

		defines 
		{ 
			"_GLFW_WIN32",
			"_CRT_SECURE_NO_WARNINGS"
		}

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter { "system:windows", "configurations:Debug-AS" }	
		runtime "Debug"
		symbols "on"
		sanitize { "Address" }
		flags { "NoRuntimeChecks", "NoIncrementalLink" }

	filter "configurations:Release"
		runtime "Release"
		optimize "speed"

    filter "configurations:Dist"
		runtime "Release"
		optimize "speed"
        symbols "off"

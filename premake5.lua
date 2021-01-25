include "./dependencies/windows/Premake5/premake_customization/solution_items.lua"

workspace "Sonic-CD-11-Decompilation"
	architecture "x64"

	configurations
	{
		"Debug",
		"Release",
	}

	solution_items
	{
		".gitignore",
		".gitmodules",
		"premake5.lua"
	}

	startproject "Sonic-CD"

outputDir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["SDL2"] = "dependencies/windows/SDL2/include"
IncludeDir["libogg"] = "dependencies/windows/libogg/include"
IncludeDir["libvorbis"] = "dependencies/windows/libvorbis/include"
IncludeDir["libtheora"] = "dependencies/windows/libtheora/include"

LibDir = {}
LibDir["SDL2"] = "dependencies/windows/SDL2/bin/" .. outputDir .. "/SDL/"
LibDir["SDL2Main"] = "dependencies/windows/SDL2/bin/" .. outputDir .. "/SDL2Main/"
LibDir["libogg"] = "dependencies/windows/libogg/bin/" .. outputDir .. "/libogg/"
LibDir["libvorbis"] = "dependencies/windows/libvorbis/bin/" .. outputDir .. "/libvorbis/"
LibDir["libvorbisfile"] = "dependencies/windows/libvorbis/bin/" .. outputDir .. "/libvorbisfile/"
LibDir["libtheora"] = "dependencies/windows/libtheora/bin/" .. outputDir .. "/theora/"

group "Dependencies"
	include "dependencies/windows/SDL2"
	include "dependencies/windows/libogg"
	include "dependencies/windows/libvorbis"
	include "dependencies/windows/libtheora"
group ""  -- end grouping

project "Sonic-CD"
	location "SonicCDDecomp"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputDir .. "/%{prj.name}")
	objdir ("obj/" .. outputDir .. "/%{prj.name}")

	libdirs 
	{
		"%{LibDir.SDL2}",
		"%{LibDir.SDL2Main}",
		"%{LibDir.libogg}",
		"%{LibDir.libvorbis}",
		"%{LibDir.libvorbisfile}",
		"%{LibDir.libtheora}",
	}

	files
	{
		"SonicCDDecomp/**.h",
		"SonicCDDecomp/**.hpp",
		"SonicCDDecomp/**.cpp",
		"dependencies/all/theoraplay/*.h",
		"dependencies/all/theoraplay/*.c",
	}

	defines
	{

	}

	includedirs
	{
		"SonicCDDecomp",		
		"%{IncludeDir.SDL2}",
		"%{IncludeDir.libogg}",
		"%{IncludeDir.libvorbis}",
		"%{IncludeDir.libtheora}",
		"dependencies/all/theoraplay/"
	}

	links
	{
		"SDL2.dll",
		"SDL2main.lib",
		"libogg.lib",
		"theora.lib",
		"libvorbis.lib",
		"libvorbisfile.lib",
	}

	filter "system:windows"
	systemversion "latest"

	filter "configurations:Release"
		defines "SCD_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Debug"
		defines "SCD_DEBUG"
		runtime "Debug"
		symbols "On"

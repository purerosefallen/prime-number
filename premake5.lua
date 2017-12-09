workspace "lua"
   configurations { "Debug", "Release" }
   language "C++"
   targetdir "bin/%{cfg.buildcfg}"

   filter "configurations:Debug"
      defines { "DEBUG" }
      flags { "Symbols" }

   filter "configurations:Release"
      defines { "NDEBUG" }
      optimize "On"

project "lua"
   kind "ConsoleApp"
   files { "lua/lua.c" }
   links { "liblua" }   

project "luac"
   kind "ConsoleApp"
   files { "lua/luac.c" }
   links { "liblua" }   

project "liblua"
   kind "StaticLib"
   files { "lua/*.h", "lua/*.c" }
   removefiles { "lua/lua.c", "lua/luac.c" }
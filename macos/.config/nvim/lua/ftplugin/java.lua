local jdtls = require("jdtls")
local root_dir = vim.fn.getcwd()
local workspace_folder = vim.fn.stdpath("data") .. "/site/java/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- Đường dẫn SDKMAN với các phiên bản cụ thể
local home = os.getenv("HOME")
local sdkman_dir = home .. "/.sdkman/candidates"
local java_dir = sdkman_dir .. "/java/21.0.6-tem"
local maven_dir = sdkman_dir .. "/maven/3.9.9"
local gradle_dir = sdkman_dir .. "/gradle/8.12.1"
local springboot_dir = sdkman_dir .. "/springboot/3.4.2"
local jdtls_dir = home .. "/.local/share/nvim/mason/packages/jdtls" -- Giả định jdtls được cài đặt qua mason

-- Đường dẫn Lombok - kiểm tra trong dự án hoặc .m2 repository
local lombok_path = vim.fn.glob(home .. "/.m2/repository/org/projectlombok/lombok/1.18.30/lombok-1.18.30.jar")
if lombok_path == "" then
  -- Thử tìm trong thư mục dự án hiện tại
  lombok_path = vim.fn.glob(root_dir .. "/lombok.jar")
end

local config = {
  cmd = {
    java_dir .. "/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path,
    "-Xbootclasspath/a:" .. lombok_path,
    "-Xms1g",
    "-Xmx2g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.nio=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.time=ALL-UNNAMED",
    "--add-opens",
    "java.base/sun.nio.fs=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(jdtls_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    jdtls_dir .. "/config_mac", -- Thay đổi thành config_mac nếu dùng macOS hoặc config_win nếu dùng Windows
    "-data",
    workspace_folder,
  },
  root_dir = root_dir,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.mockito.Answers.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      referencesCodeLens = { enabled = true },
      implementationsCodeLens = { enabled = true },
      inlayHints = { parameterNames = { enabled = true } },
      configuration = {
        updateBuildConfiguration = "interactive",
        maven = {
          userSettings = home .. "/.m2/settings.xml",
          globalSettings = maven_dir .. "/conf/settings.xml",
        },
        runtimes = {
          {
            name = "JavaSE-21",
            path = java_dir,
            default = true,
          },
        },
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },
      gradle = {
        enabled = true,
        wrapper = {
          enabled = true,
        },
        home = gradle_dir,
        java = {
          home = java_dir,
        },
        downloadSources = true,
        annotationProcessing = {
          enabled = true,
        },
      },
      format = {
        enabled = true,
        settings = {
          url = root_dir .. "/.vscode/java-formatter.xml",
          profile = "GoogleStyle",
        },
      },
      saveActions = {
        organizeImports = true,
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
      },
    },
  },
  init_options = {
    bundles = { lombok_path },
    extendedClientCapabilities = {
      progressReportProvider = true,
      classFileContentsSupport = true,
      generateToStringPromptSupport = true,
      hashCodeEqualsPromptSupport = true,
      advancedExtractRefactoringSupport = true,
      advancedOrganizeImportsSupport = true,
      generateConstructorsPromptSupport = true,
      generateDelegateMethodsPromptSupport = true,
    },
  },
}

jdtls.start_or_attach(config)

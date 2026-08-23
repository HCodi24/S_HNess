# S_HNess

`S_HNess` là harness kỹ thuật cá nhân được xây mới hoàn toàn. Hiện tại harness có lớp core và bốn domain pack độc lập: Web full-stack, Backend, Frontend và Tool Builder. IoT có thể được bổ sung ở giai đoạn sau.

## Cấu trúc

```text
S_HNess/
|-- AGENTS.md
|-- README.md
|-- packs/
|   |-- s-hness-core/
|   |-- s-hness-web/
|   |-- s-hness-backend/
|   |-- s-hness-frontend/
|   `-- s-hness-tools/
`-- scripts/
    `-- validate-harness.ps1
```

Mỗi pack có manifest `.codex-plugin/plugin.json`, các skill riêng và reference chuyên môn. Core sở hữu vòng đời chung; domain pack không lặp lại discovery, spec, plan, execution hay review.

## Core

- `$s-route`: xác định phase, domain, workspace, side effect và bằng chứng cần có.
- `$s-discover`: làm rõ mục tiêu, phạm vi và tiêu chí thành công.
- `$s-spec`: định nghĩa behavior, interface, failure và acceptance criteria có thể kiểm thử.
- `$s-plan`: tạo kế hoạch triển khai đầy đủ quyết định.
- `$s-cook`: điều phối plan nhiều phase qua run, verify và review gate.
- `$s-run`: thực hiện một phase hoặc thay đổi tập trung.
- `$s-verify`: kiểm chứng theo acceptance criteria.
- `$s-review`: review chỉ đọc, ưu tiên lỗi và rủi ro.

## Domain packs

Web:

- `$web-system-design`, `$web-integration`, `$web-deployment`, `$web-verify`.

Backend:

- `$be-api-design`, `$be-data-design`, `$be-service-design`, `$be-security-reliability`, `$be-verify`.

Frontend:

- `$fe-architecture`, `$fe-ui`, `$fe-state-data`, `$fe-quality`, `$fe-verify`.

Tool Builder:

- `$tool-product-design`: chọn loại tool, kiến trúc runtime và cấu trúc project.
- `$tool-interface-design`: thiết kế giao diện CLI, TUI, desktop, chat, plugin, add-in hoặc automation.
- `$tool-integration-design`: thiết kế boundary với SDK, API, file, OS, process, device hoặc ứng dụng host.
- `$tool-packaging-design`: thiết kế build, package, cài đặt, update, migration, rollback và uninstall.
- `$tool-delivery-verify`: kiểm chứng source, behavior, integration, package và vòng đời bàn giao.

Tool Builder hỗ trợ theo hướng stack-neutral cho CLI, TUI, desktop, chat tool, plugin/add-in, automation worker, library và service tool.

## Structure gate

Khi tạo mới, tái cấu trúc hoặc mở rộng source đáng kể, plan phải có:

- cây thư mục hiện tại và cây đề xuất;
- trách nhiệm của từng thư mục được thêm hoặc thay đổi;
- dependency/import direction;
- vị trí entry point, source, integration, configuration, packaging và test;
- lý do khi thay đổi convention hiện có.

Backend dùng `$be-service-design`, Frontend dùng `$fe-architecture`, và Tool Builder dùng `$tool-product-design` để quản lý structure gate. Không tạo thư mục rỗng hoặc layer không có trách nhiệm rõ ràng.

## Cách dùng

Vòng đời chuẩn:

```text
$s-discover -> $s-spec -> domain design -> $s-plan -> $s-cook
```

### Quy tắc bắt buộc của plan

Mỗi lần `$s-plan` được gọi hoặc được router chọn cho yêu cầu planning, harness phải tạo hoặc cập nhật `plan.md` ngay tại root của workspace dự án hiện tại. Sau khi ghi, harness phải đọc lại file và trả về đường dẫn tuyệt đối; nếu không ghi hoặc không đọc lại được thì planning chưa hoàn thành.

`/plan` là slash command native dùng để chuyển Codex sang Plan Mode. Nó không thể bị plugin đổi thành một slash command khác. Khi đã vào `/plan`, yêu cầu planning tiếp theo phải áp dụng workflow `$s-plan` để tạo `plan.md`:

```text
/plan
$s-plan tools Lên kế hoạch xây CLI cho dự án hiện tại.
```

Không cần yêu cầu thêm “hãy lưu file”. Việc gọi `$s-plan` đã cho phép tạo hoặc cập nhật duy nhất `plan.md`; nó không cho phép sửa source sản phẩm.

Ví dụ xây một tool:

```text
$s-spec tools Đặc tả một CLI đồng bộ dữ liệu có chế độ chạy tự động.
$tool-product-design Chọn loại tool, kiến trúc và cây thư mục cho CLI này.
$tool-interface-design Thiết kế command, help, exit code và JSON output.
$s-plan tools Lên kế hoạch triển khai CLI theo đặc tả đã duyệt và tạo plan.md tại root dự án.
$s-cook C:\du-an\plan.md
```

Ví dụ các domain khác:

```text
$s-plan web Lên kế hoạch xây website bán hàng full-stack.
$s-plan backend Thiết kế API và persistence cho đơn hàng.
$s-plan frontend Xây giao diện quản lý đơn hàng.
```

Không dùng `/planweb` hoặc `/plan /web`. Slash command là chức năng có sẵn của Codex; skill tùy chỉnh được gọi bằng `$skill-name`, còn domain là đối số như `$s-plan tools ...`.

## Test gate tự động

Sau mỗi phase và trước kết quả cuối, `$s-cook` phải tìm lệnh test của project, chạy kiểm tra tập trung, bổ sung regression test phù hợp trong scope và chạy suite rộng hơn theo mức rủi ro. Kết quả cuối chỉ có thể là:

- `verified`: mọi bằng chứng bắt buộc đã chạy và pass;
- `failed`: bằng chứng bắt buộc đã chạy và fail;
- `unverified`: thiếu môi trường, dependency, thiết bị, ứng dụng host hoặc lệnh kiểm tra.

Mock không chứng minh được tích hợp thật với OS, thiết bị, SDK, ứng dụng host hay dịch vụ ngoài.

## Ranh giới

Harness chỉ chứa chỉ dẫn tái sử dụng. Plan, source code, test, báo cáo và build artifact phải nằm trong workspace sản phẩm do người dùng chỉ định. Không tự cài đặt, commit, publish hoặc deploy.

## Cài plugin trên máy mới

### Yêu cầu

- Đã cài Codex và lệnh `codex` chạy được trong PowerShell.
- Đã cài Python và lệnh `python` chạy được.
- Đã chép hoặc clone thư mục `S_HNess` sang máy mới.
- Chưa có các thư mục `s-hness-*` trong thư mục plugin cá nhân. Quy trình dưới đây sẽ dừng thay vì ghi đè nếu phát hiện bản cài cũ.

Mở PowerShell tại root `S_HNess`, sau đó chạy:

```powershell
$ErrorActionPreference = 'Stop'

$HarnessRoot = (Get-Location).Path
$UserRoot = [Environment]::GetFolderPath('UserProfile')
$PluginRoot = Join-Path $UserRoot 'plugins'
$HelperRoot = Join-Path $UserRoot '.codex\skills\.system\plugin-creator\scripts'
$Creator = Join-Path $HelperRoot 'create_basic_plugin.py'
$Cachebuster = Join-Path $HelperRoot 'update_plugin_cachebuster.py'
$Validator = Join-Path $HelperRoot 'validate_plugin.py'
$PluginNames = @(
    's-hness-core',
    's-hness-web',
    's-hness-backend',
    's-hness-frontend',
    's-hness-tools'
)

foreach ($RequiredPath in @($Creator, $Cachebuster, $Validator)) {
    if (-not (Test-Path -LiteralPath $RequiredPath -PathType Leaf)) {
        throw "Không tìm thấy helper của Codex: $RequiredPath"
    }
}

New-Item -ItemType Directory -Path $PluginRoot -Force | Out-Null

foreach ($PluginName in $PluginNames) {
    $Source = Join-Path $HarnessRoot "packs\$PluginName"
    $Target = Join-Path $PluginRoot $PluginName

    if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
        throw "Không tìm thấy source plugin: $Source"
    }
    if (Test-Path -LiteralPath $Target) {
        throw "Plugin đã tồn tại, không ghi đè: $Target"
    }

    python $Creator $PluginName --path $PluginRoot --with-marketplace
    if ($LASTEXITCODE -ne 0) { throw "Không tạo được marketplace entry: $PluginName" }

    Get-ChildItem -LiteralPath $Source -Force |
        Copy-Item -Destination $Target -Recurse -Force

    python $Cachebuster $Target
    if ($LASTEXITCODE -ne 0) { throw "Không tạo được cachebuster: $PluginName" }

    python $Validator $Target
    if ($LASTEXITCODE -ne 0) { throw "Plugin không hợp lệ: $PluginName" }

    codex plugin add "$PluginName@personal"
    if ($LASTEXITCODE -ne 0) { throw "Không cài được plugin: $PluginName" }
}

codex plugin list
```

Kết quả mong đợi trong marketplace `personal`:

```text
s-hness-core       installed, enabled
s-hness-web        installed, enabled
s-hness-backend    installed, enabled
s-hness-frontend   installed, enabled
s-hness-tools      installed, enabled
```

Marketplace cá nhân được Codex quản lý tại `%USERPROFILE%\.agents\plugins\marketplace.json`; không cần chạy `codex plugin marketplace add` và không sửa file này bằng tay.

Sau khi cài xong, mở một thread Codex mới để nạp các skill. Có thể kiểm tra nhanh bằng:

```text
$s-route Lên kế hoạch xây một CLI quản lý file.
$s-plan tools Lên kế hoạch xây một CLI quản lý file.
```

## Kiểm tra harness

Chạy từ root `S_HNess`:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-harness.ps1
```

Script kiểm tra manifest, strict semver, frontmatter, tên skill trùng, placeholder và liên kết Markdown nội bộ.

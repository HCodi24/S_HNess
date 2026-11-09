# S_HNess

`S_HNess` là harness kỹ thuật cá nhân được xây mới hoàn toàn. Hiện tại harness có lớp core, các capability domain nội bộ (Web full-stack, Backend, Frontend và Tool Builder) cùng một plugin bảo trì cục bộ. IoT có thể được bổ sung ở giai đoạn sau.

## Cấu trúc

```text
S_HNess/
|-- AGENTS.md
|-- README.md
|-- packs/
|   |-- s-hness-core/
|   |   `-- references/domain/
|   `-- s-hness-maintenance/
`-- scripts/
    `-- validate-harness.ps1
```

Core là plugin public duy nhất cung cấp lifecycle. Capability backend/frontend/web/tools nằm dưới `packs/s-hness-core/references/domain/` và được lifecycle skill tự route qua registry; chúng không còn là public skill entry độc lập. Plugin maintenance vẫn chỉ được dùng khi người dùng yêu cầu rõ.

## Core

- `$s-route`: xác định phase, domain, workspace, side effect và bằng chứng cần có.
- `$s-control`: cấp quyền, cấu hình và điều khiển một app/website cụ thể trong giới hạn người dùng phê duyệt.
- `$s-discover`: làm rõ mục tiêu, phạm vi và tiêu chí thành công.
- `$s-spec`: định nghĩa behavior, interface, failure và acceptance criteria có thể kiểm thử.
- `$s-plan`: tạo kế hoạch triển khai đầy đủ quyết định.
- `$s-cook`: điều phối plan nhiều phase qua run, verify và review gate.
- `$s-loop`: tự động chạy từng phase, checkpoint/resume, test theo risk, repair có giới hạn và ghi log/artifacts.
- `$s-run`: thực hiện một phase hoặc thay đổi tập trung.
- `$s-test`: chạy quy trình test theo risk, phân loại lỗi và bàn giao bằng chứng.
- `$s-verify`: kiểm chứng theo acceptance criteria.
- `$s-review`: review chỉ đọc, ưu tiên lỗi và rủi ro.
- `$s-feedback`: ghi lại hành vi không mong muốn của harness vào `HARNESS_FEEDBACK.md` (mặc định), hoặc sửa tập trung source harness khi được yêu cầu rõ.

Root harness canonical được xác định theo thứ tự: đường dẫn người dùng chỉ định, biến môi trường `S_HNESS_ROOT`, rồi mặc định `C:\GitHub\S_HNess`. Đặt `S_HNESS_ROOT` nếu clone harness ở vị trí khác.

Core tự route domain theo yêu cầu. Ví dụ `$s-plan Xây màn hình quản lý đơn hàng có API và phân quyền` sẽ xác định phase `plan`, chọn capability frontend và backend phù hợp, rồi đọc guidance nội bộ tương ứng. Người dùng không cần biết hoặc gọi riêng tên `fe-*`, `be-*`, `web-*` hay `tool-*`. Gọi `$s-route` riêng chỉ khi muốn xem contract định tuyến.
## Domain capabilities (internal)

Core tự route tới các capability sau khi phân tích yêu cầu; người dùng không cần gọi trực tiếp các tên này:

Web: `web-system-design`, `web-integration`, `web-deployment`, `web-verify`.

Backend: `be-api-design`, `be-data-design`, `be-service-design`, `be-security-reliability`, `be-verify`.

Frontend: `fe-architecture`, `fe-ui`, `fe-state-data`, `fe-quality`, `fe-verify`.

Tool Builder: `tool-product-design`, `tool-interface-design`, `tool-integration-design`, `tool-packaging-design`, `tool-delivery-verify`, `ai-control-runtime`.

Source của các capability nằm trong `packs/s-hness-core/references/domain/` và được ánh xạ bởi `domain-capabilities.md`.

`ai-control-runtime` là capability chung để thiết kế runtime cho AI tương tác với app/web qua API, CLI, MCP, browser automation hoặc desktop control. Automated testing là một workflow chính; runtime source và profile của từng project sẽ được tạo ở giai đoạn sau.

`s-control` là entrypoint người dùng gọi để cấp quyền và bắt đầu tương tác với một target cụ thể. Skill này tạo hoặc cập nhật profile trong project đích, nhưng chỉ kích hoạt grant/attach/live action sau khi người dùng phê duyệt rõ ràng. `ai-control-runtime` vẫn là lớp contract và thực thi phía sau, không phải profile của từng app.
## Maintenance

- `$s-reinstall`: preflight, staging, cachebuster, validation, backup, reinstall và rollback plugin S_HNess cục bộ bằng một script deterministic.

Luồng này chỉ chạy khi người dùng yêu cầu rõ plugin cần refresh. Skill phải dry-run trước, báo source–target–backup và xin xác nhận ngay trước khi ghi ngoài repository. Backup được giữ lại mặc định; không sửa tay marketplace hoặc cấu hình Codex.

Máy đã cài các plugin S_HNess trước khi có plugin maintenance cần bootstrap thủ công đúng một lần:

```powershell
$ErrorActionPreference = 'Stop'
$HarnessRoot = (Get-Location).Path  # chạy tại root S_HNess
$UserRoot = [Environment]::GetFolderPath('UserProfile')
$PluginRoot = Join-Path $UserRoot 'plugins'
$PluginName = 's-hness-maintenance'
$Source = Join-Path $HarnessRoot "packs\$PluginName"
$Target = Join-Path $PluginRoot $PluginName
$HelperRoot = Join-Path $UserRoot '.codex\skills\.system\plugin-creator\scripts'

if (Test-Path -LiteralPath $Target) {
    throw "Plugin đã tồn tại, không ghi đè: $Target"
}

python (Join-Path $HelperRoot 'create_basic_plugin.py') $PluginName --path $PluginRoot --with-marketplace
if ($LASTEXITCODE -ne 0) { throw 'Không tạo được plugin/marketplace entry.' }
Get-ChildItem -LiteralPath $Source -Force | Copy-Item -Destination $Target -Recurse -Force
python (Join-Path $HelperRoot 'update_plugin_cachebuster.py') $Target
if ($LASTEXITCODE -ne 0) { throw 'Không cập nhật được cachebuster.' }
python (Join-Path $HelperRoot 'validate_plugin.py') $Target
if ($LASTEXITCODE -ne 0) { throw 'Plugin maintenance không hợp lệ.' }
codex plugin add "$PluginName@personal"
if ($LASTEXITCODE -ne 0) { throw 'Không cài được plugin maintenance.' }
```

Sau khi bootstrap, mở thread mới và dùng `$s-reinstall`; không lặp lại block bootstrap để cập nhật plugin đã tồn tại.

## Structure gate

Khi tạo mới, tái cấu trúc hoặc mở rộng source đáng kể, plan phải có:

- cây thư mục hiện tại và cây đề xuất;
- trách nhiệm của từng thư mục được thêm hoặc thay đổi;
- dependency/import direction;
- vị trí entry point, source, integration, configuration, packaging và test;
- lý do khi thay đổi convention hiện có.

Core tự nạp capability nội bộ `be-service-design` cho Backend, `fe-architecture` cho Frontend và `tool-product-design` cho Tool Builder để quản lý structure gate. Không tạo thư mục rỗng hoặc layer không có trách nhiệm rõ ràng.

## Cách dùng

Vòng đời chuẩn:

```text
$s-discover -> $s-spec -> domain design -> $s-plan -> $s-cook
```

### Quy tắc bắt buộc của plan

Mỗi chủ đề planning độc lập phải có artifact riêng tại `plans/<topic-slug>.md` trong workspace dự án hiện tại. Tên file dùng slug ngắn, ổn định và phản ánh chủ đề, ví dụ `plans/image-to-cad.md`. Harness chỉ cập nhật plan cũ khi người dùng nêu đúng path hoặc yêu cầu rõ tiếp tục plan đã xác định trong hội thoại; không nối chủ đề mới vào `plan.md` chỉ vì file đó đã tồn tại.

`/plan` là slash command native dùng để chuyển Codex sang Plan Mode. Nó không thể bị plugin đổi thành một slash command khác. Khi đã vào `/plan`, yêu cầu planning tiếp theo vẫn phải áp dụng workflow `$s-plan` để tạo plan theo chủ đề:

```text
/plan
$s-plan tools Lên kế hoạch xây CLI cho dự án hiện tại.
```

Không cần yêu cầu thêm “hãy lưu file”. Việc gọi `$s-plan` chỉ cho phép tạo hoặc cập nhật plan artifact đã chọn; nó không cho phép sửa source sản phẩm. Sau khi ghi, harness phải đọc lại file và trả về đường dẫn tuyệt đối. Nếu slug trùng một plan không liên quan, harness phải chọn slug cụ thể hơn thay vì ghi đè.

`plan.md` cũ vẫn có thể được dùng khi người dùng chỉ rõ path đó. Khi có nhiều plan và người dùng chưa chọn, `$s-cook` phải hỏi path thay vì tự chọn file mới nhất hoặc file có tên gần giống.

Ví dụ xây một tool:

```text
$s-spec tools Đặc tả một CLI đồng bộ dữ liệu có chế độ chạy tự động.
$s-plan tools Lên kế hoạch triển khai CLI theo đặc tả đã duyệt (loại tool, kiến trúc, cây thư mục, command, exit code, JSON output) và tạo plans/cli-dong-bo-du-lieu.md.
$s-cook C:\du-an\plans\cli-dong-bo-du-lieu.md
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
    's-hness-maintenance'
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
s-hness-maintenance installed, enabled
```

Marketplace cá nhân được Codex quản lý tại `%USERPROFILE%\.agents\plugins\marketplace.json`; không cần chạy `codex plugin marketplace add` và không sửa file này bằng tay.

Sau khi cài xong, mở một thread Codex mới để nạp các skill. Có thể kiểm tra nhanh bằng:

```text
$s-route Lên kế hoạch xây một CLI quản lý file.
$s-plan tools Lên kế hoạch xây một CLI quản lý file.
$s-reinstall s-hness-core.
```

## Kiểm tra harness

Chạy từ root `S_HNess`:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\validate-harness.ps1
```

Script kiểm tra manifest, strict semver, frontmatter, tên skill trùng, placeholder, liên kết Markdown nội bộ, bảng Markdown bị chen văn bản không phải bảng, gọi capability nội bộ như skill public (`$<capability>`), đường dẫn harness root hard-code khác mặc định `C:\GitHub\S_HNess`, phase trong routing contract bị thiếu trong `s-route`, và báo cáo tất cả lỗi trong một lượt.

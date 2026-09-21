# Kế hoạch: ai-control-runtime — Skill cấp quyền và runtime điều khiển AI

## Mục tiêu

Xây một cơ chế control tổng quát để người dùng gọi một skill nhằm cấp quyền cho phần mềm hoặc website cụ thể. Skill sẽ tạo/đọc profile quyền của project, xin phê duyệt trước khi kích hoạt, chọn driver phù hợp và ủy quyền cho runtime thực hiện tương tác. Runtime hỗ trợ automated testing như một workflow chính, nhưng không bị giới hạn ở testing.

## Phạm vi thực hiện hiện tại

Giai đoạn hiện tại chỉ triển khai phần harness: public skill `$s-control`, contract, permission model, driver/integration guidance, interface, project configuration và verification profile cho `ai-control-runtime`. Chưa tạo runtime source, chưa tích hợp app/web thật và chưa đưa credential hoặc profile project cụ thể vào harness.

## Ranh giới trách nhiệm

```text
S_HNess core
  → cung cấp `$s-control`, route control request và điều phối lifecycle

s-hness-tools internal procedures
  → định nghĩa tool contract, integration, interface và verification

Target project runtime
  → code thực sự điều khiển app/web và nhận grant đã được phê duyệt

Codex/OS/Computer Use/API/MCP
  → execution backend
```

## Cấu trúc runtime dự kiến

```text
target-project/
├── app-test-runtime/
│   ├── src/
│   │   ├── orchestrator/
│   │   ├── loop/
│   │   ├── permissions/
│   │   ├── evidence/
│   │   ├── recovery/
│   │   └── drivers/
│   │       ├── desktop/
│   │       │   ├── computer-use/
│   │       │   ├── ui-automation/
│   │       │   └── process-native/
│   │       ├── browser/
│   │       │   ├── browser-use/
│   │       │   ├── web-ui/
│   │       │   └── webmcp-or-api/
│   │       └── mcp/
│   └── tests/
├── apps/
│   └── solidworks.yaml
├── web/
│   └── test-sites.yaml
├── permissions.yaml
├── test-plans/
├── workflows/
├── loop-policy.yaml
└── artifacts/
```

`artifacts/` chứa screenshot, video, log, report và output test; không commit artifact mặc định.

## Capability contract

Runtime cần cung cấp interface thống nhất cho:

- mở, focus, attach và đóng app;
- đọc cửa sổ, màn hình, log và trạng thái;
- click, type, hotkey, select và điều hướng UI;
- mở, sửa, lưu và xác minh file test;
- mở trang web, chuyển tab, thao tác form và kiểm tra UI/DOM;
- gọi CLI, API hoặc MCP khi đó là đường dẫn ổn định hơn UI;
- chụp evidence và ghi assertion;
- timeout, retry, recovery và emergency stop.

## Driver strategy

Ưu tiên đường dẫn thực thi theo thứ tự:

```text
Native/API/CLI
  → UI automation
  → Computer Use hoặc browser interaction fallback
```

Engine dùng chung; mỗi app hoặc website chỉ cần profile riêng gồm:

- process/window identifier;
- launch hoặc attach method;
- selector/UI hints;
- action allowlist;
- điều kiện xác minh;
- cách reset test state.

## Quyền

Quyền hiệu lực là giao của ba lớp:

```text
Harness safety ceiling
  ∩ Project allowlist
  ∩ OS/Codex/app permissions
```

Action mở app, đọc trạng thái và chạy test có thể tự động nếu nằm trong scope. Xóa dữ liệu, publish, gửi dữ liệu ra ngoài hoặc đóng app có file chưa lưu cần policy và approval riêng.

## Chu trình runtime

```text
Core route request
  → load project manifest
  → authorize app/web capability
  → launch hoặc attach
  → execute test actions
  → observe UI/log/output
  → assert expected result
  → lưu evidence
  → retry/recover hoặc stop
  → cleanup và report
```

## Loop dài hạn

```yaml
mode: test-only
max_iterations: 20
max_duration_minutes: 120
retry_per_test: 2
stop_on_repeated_failure: 3
auto_fix: false
```

Nếu bật `auto_fix`, việc sửa code phải chạy trong workspace/branch được cấp quyền và vẫn chịu giới hạn iteration, duration, diff size và emergency stop.

## Verification

Phải kiểm thử với app/web thật khi có thể, không coi mock là bằng chứng live integration. Cần kiểm tra:

- mở và attach được app thật;
- thao tác được website thật trong scope;
- quyền bị từ chối thì runtime dừng đúng;
- app/web treo có watchdog và recovery;
- evidence được tạo đầy đủ;
- loop dài có giới hạn và dừng khẩn cấp;
- kết quả phân biệt được `pass`, `fail` và `unverified`.

## Trạng thái

Đây là phần bổ sung cho kế hoạch core-routed domain skills. Chưa triển khai runtime hoặc thay đổi plugin/harness.

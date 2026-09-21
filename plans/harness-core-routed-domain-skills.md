# Kế hoạch: Core tự route domain skills trong S_HNess

## Mục tiêu

Điều chỉnh cách đóng gói và routing skill để người dùng chỉ nhìn thấy và gọi các skill thuộc `s-hness-core`. Các skill chuyên môn của backend, frontend, web và tools vẫn được giữ nguyên nội dung, nhưng được core tự nạp khi phase và domain phù hợp.

## Phạm vi

### Bao gồm

- `s-hness-core` là bề mặt skill chính cho người dùng.
- `s-hness-backend` trở thành domain capability nội bộ.
- `s-hness-frontend` trở thành domain capability nội bộ.
- `s-hness-web` trở thành domain capability nội bộ.
- `s-hness-tools` trở thành domain capability nội bộ.
- Core routing xác định phase, domain, side-effect class, approval need và verification expectation trước khi nạp capability nội bộ.
- Giữ nguyên nội dung chuyên môn của các skill domain, chỉ thay đổi cách đăng ký và nạp chúng.

### Không bao gồm

- Không xóa nội dung các skill domain.
- Không sửa trực tiếp thư mục plugin cache đã cài.
- Không tự động nạp `s-hness-maintenance`; pack này chỉ được dùng khi người dùng yêu cầu reinstall/refresh plugin.
- Không thay đổi runtime điều khiển app, Computer Use, MCP hoặc test runner trong giai đoạn này.
- Không đưa app cụ thể, credential, đường dẫn máy người dùng hoặc test artifact vào harness.

## Quyết định kiến trúc

```text
Người dùng
    ↓
s-hness-core public skills
    ↓
Core routing
    ↓
Internal domain capability
    ├── backend
    ├── frontend
    ├── web
    └── tools
```

Skill domain không nên tiếp tục là các entry độc lập trên bề mặt `$` nếu cơ chế plugin không hỗ trợ metadata `hidden`. Cách triển khai dự kiến là chuyển chúng thành internal references/procedures hoặc một dạng đăng ký nội bộ mà core có thể nạp theo routing.

## Mapping routing dự kiến

| Phase hoặc tín hiệu | Domain | Capability nội bộ |
|---|---|---|
| discover/spec/plan/run/verify/review | backend | các `be-*` phù hợp |
| discover/spec/plan/run/verify/review | frontend | các `fe-*` phù hợp |
| discover/spec/plan/run/verify/review | web | các `web-*` phù hợp |
| discover/spec/plan/run/verify/deliver | software tool | các `tool-*` phù hợp |
| reinstall/refresh local S_HNess plugin | maintenance | chỉ dùng khi explicit |

Core phải chọn domain hẹp nhất; chỉ chọn `multi` khi request thực sự có nhiều trách nhiệm domain.

## Cấu trúc source dự kiến

Cấu trúc cuối cùng phải bám theo manifest plugin thực tế sau khi đã đọc source canonical:

```text
packs/
├── s-hness-core/
│   └── skills/
│       ├── s-route/
│       ├── s-spec/
│       ├── s-plan/
│       ├── s-run/
│       ├── s-verify/
│       └── ...
├── s-hness-backend/
│   └── internal/ hoặc references/
│       └── be-*/
├── s-hness-frontend/
│   └── internal/ hoặc references/
│       └── fe-*/
├── s-hness-web/
│   └── internal/ hoặc references/
│       └── web-*/
└── s-hness-tools/
    └── internal/ hoặc references/
        └── tool-*/
```

Không được chọn giữa `internal/`, `references/` hoặc thay đổi manifest chỉ dựa trên giả định. Cần đọc các `*.codex-plugin/plugin.json` và kiểm tra cách plugin loader đăng ký skill trước.

## Chu trình thực hiện

### Bước 1: Kiểm tra source canonical

- Đọc manifest của core, backend, frontend, web và tools.
- Đọc cấu trúc plugin và cách các thư mục `skills/` được phát hiện.
- Kiểm tra các reference tương đối trong từng `SKILL.md`.
- Xác định source canonical khác với cache cài đặt như thế nào.

### Bước 2: Thiết kế routing contract

- Mở rộng routing contract của `s-route` để biểu diễn domain capability nội bộ.
- Bổ sung mapping từ phase/domain sang capability.
- Quy định explicit skill invocation vẫn được ưu tiên khi người dùng cố ý gọi một capability.
- Quy định core không tự coi routing là quyền mutate, install, publish hoặc deploy.

### Bước 3: Chuyển domain skills khỏi public surface

- Giữ nguyên nội dung và references của từng domain skill.
- Di chuyển hoặc đăng ký lại chúng thành internal resources theo manifest thực tế.
- Chỉ để core skills được index như public skills.
- Cập nhật đường dẫn reference sau khi di chuyển.

### Bước 4: Cập nhật core routing

- Sửa `s-route` để nạp capability nội bộ theo phase/domain.
- Cập nhật các skill lifecycle liên quan nếu chúng cần biết domain capability.
- Không nhúng toàn bộ nội dung domain vào core; core chỉ route và nạp đúng phần cần thiết.

### Bước 5: Kiểm tra plugin và cache boundary

- Validate manifest JSON.
- Kiểm tra source tree không còn domain skill nào bị đăng ký public ngoài chủ ý.
- Không sửa trực tiếp `C:\Users\...\.codex\plugins\cache\...`.
- Nếu cần hiệu lực trong Codex, dùng quy trình refresh/reinstall phù hợp sau khi source đã được kiểm tra.

### Bước 6: Verification

- Kiểm tra các skill core vẫn được phát hiện.
- Kiểm tra domain skill không còn xuất hiện độc lập trên public skill surface nếu loader hỗ trợ mô hình internal.
- Gửi request backend, frontend, web và tools để xác minh core route đúng capability.
- Kiểm tra explicit invocation của core vẫn hoạt động.
- Kiểm tra maintenance không tự động được route khi người dùng không yêu cầu reinstall/refresh.
- Ghi lại giới hạn nếu client/plugin loader không hỗ trợ internal skill visibility.

## Acceptance criteria

- Người dùng có thể sử dụng core skill hoặc mô tả yêu cầu tự nhiên mà không cần biết tên `be-*`, `fe-*`, `web-*` hoặc `tool-*`.
- Core xác định đúng phase và domain trước khi nạp capability.
- Nội dung domain skill không bị mất và vẫn có thể được core sử dụng.
- Không có credential, app-specific configuration hoặc runtime source bị đưa vào harness.
- Plugin manifests hợp lệ và source/cached installation boundary rõ ràng.
- Nếu nền tảng không hỗ trợ ẩn skill theo manifest, kế hoạch phải báo rõ là `unverified` thay vì tuyên bố đã ẩn thành công.

## Rủi ro và cách xử lý

| Rủi ro | Xử lý |
|---|---|
| Plugin loader chỉ quét `skills/` và không hỗ trợ internal | Giữ domain skill ở source nhưng dùng một packaging layer hoặc plugin boundary khác; không xóa nội dung |
| Reference tương đối bị hỏng khi di chuyển | Kiểm tra và sửa từng reference, sau đó đọc lại file đích |
| Core route sai domain | Test từng nhóm request và dùng domain hẹp nhất |
| Cache vẫn hiển thị skill cũ | Refresh/reinstall từ source canonical; không sửa cache thủ công |
| Explicit invocation bị mất ngoài ý muốn | Chỉ ẩn domain skill; giữ public core skills và ghi rõ override policy |

## Trạng thái hiện tại

Kế hoạch đã được tạo. Chưa có source plugin hoặc harness nào được sửa trong bước lập kế hoạch này.

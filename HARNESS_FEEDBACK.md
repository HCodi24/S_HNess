# Phản hồi S_HNess

File này là hộp thư chung cho các lỗi, hành vi không mong muốn và đề xuất cải tiến của harness được phát hiện khi làm việc ở bất kỳ dự án nào.

Mỗi mục dùng cấu trúc sau:

```markdown
### Tiêu đề ngắn

- Ngày feedback: YYYY-MM-DD
- Dự án nguồn: đường dẫn dự án, nếu biết
- Hiện trạng: hành vi quan sát được
- Mong đợi: hành vi mong muốn
- Bằng chứng/tái hiện: thông tin tối thiểu, nếu có
- Skill/pack ảnh hưởng: tên skill hoặc pack, nếu biết
```

`Ngày feedback` là ngày địa phương khi mục được ghi lần đầu và được giữ nguyên khi chuyển mục sang phần đã xử lý.

File này chỉ giữ tối đa 10 feedback gần nhất, tính theo `Ngày feedback` trên cả hai phần. Mục cũ hơn sẽ được xóa khi vượt giới hạn.

Mỗi mục trong `## Đã xử lý` phải kết thúc bằng dòng `Done`.

## Chờ xử lý

### Phase được đánh dấu hoàn thành khi acceptance còn thiếu

- Ngày feedback: 2026-08-26
- Dự án nguồn: `C:\soli2`
- Hiện trạng: Increment 5 được báo hoàn thành sau khi live-verify MVP gồm SelectPlaneOrFace, CreateSketch, AddCircle, AddRectangle và Rebuild, trong khi roadmap/acceptance còn nêu các command CAD như `ExtrudeBoss`; command này chỉ có trong catalog nhưng chưa có SolidWorks adapter/capability.
- Mong đợi: Trước khi đánh dấu phase hoàn thành, phải đối chiếu toàn bộ scope/acceptance với implementation, tests và live evidence; phần chưa làm phải được ghi rõ là pending hoặc phase phải giữ trạng thái partial.
- Bằng chứng/tái hiện: `C:\soli2\plans\solidworks-ai-assistant.md` nêu I5 command registry/executor acceptance; live capability output không có `ExtrudeBoss`; sau đó người dùng phát hiện khối 3D chưa vẽ được.
- Skill/pack ảnh hưởng: `s-cook`, `s-run`, `s-verify`, `s-hness-core`.

## Đã xử lý

Khi hoàn tất một mục, chuyển mục đó xuống đây và ghi ngắn gọn thay đổi cùng bằng chứng kiểm tra.

### Tách phase rõ ràng giữa spec, plan và cook

- Ngày feedback: 2026-08-25
- Dự án nguồn: `C:\harness\S_HNess`
- Hiện trạng: Plan có thể bị hiểu như một khối công việc duy nhất; spec chưa bắt buộc phân tích ranh giới từng phase; cook chưa nhấn mạnh việc hoàn tất từng phase trước khi chuyển tiếp.
- Mong đợi: Spec phân tích rõ từng phase; plan tách thành các phase độc lập có scope, acceptance, verification và gate; cook thực thi từng phase, ghi status và chỉ chuyển phase sau khi gate hiện tại đạt.
- Bằng chứng/tái hiện: Phản hồi trực tiếp của người dùng khi rà lại tiến trình `s-cook`.
- Skill/pack ảnh hưởng: `s-spec`, `s-plan`, `s-cook` và cook pipeline trong `s-hness-core`.
- Thay đổi: Bắt buộc phase contract trong spec/plan; `s-cook` từ chối plan thiếu phase boundary và chạy test/verify/review theo phase; sửa đánh số per-phase pipeline.
- Kiểm tra: Harness validator pass với 6 plugin và 30 skill; 12 focused invariants về phase analysis trong spec, phase contract trong plan, thực thi từng phase trong cook, gate/đánh số pipeline và giới hạn 10 feedback đều pass.
Done

### Bắt buộc hỏi kiến trúc code và UI/UX theo ngữ cảnh

- Ngày feedback: 2026-08-25
- Dự án nguồn: `C:\harness\S_HNess`
- Hiện trạng: Các bước làm rõ mục tiêu và lập kế hoạch ưu tiên tự kiểm tra workspace, nhưng chưa bắt buộc lấy ý kiến trực tiếp của người dùng về kiến trúc code và UI/UX.
- Mong đợi: Khi discovery hoặc plan, luôn hỏi người dùng về định hướng kiến trúc code; đồng thời hỏi UI/UX theo đúng loại giao diện và vấn đề đang giải quyết, hoặc ghi rõ không áp dụng khi không có tương tác người dùng.
- Bằng chứng/tái hiện: Phản hồi trực tiếp của người dùng khi gọi `s-feedback`.
- Skill/pack ảnh hưởng: `s-discover`, `s-spec`, `s-plan` và lifecycle reference trong `s-hness-core`.
- Thay đổi: Thêm user-design gate dùng chung; discovery bắt buộc lấy câu trả lời trực tiếp, specification bảo toàn các quyết định, và planning phải xác nhận chúng theo implementation boundary trước khi ghi plan.
- Kiểm tra: Harness validator pass với 6 plugin và 29 skill; 7 focused invariant về direct architecture input, UI/UX theo ngữ cảnh, propagation qua specification, planning reconfirmation, missing-decision block và giới hạn 10 feedback đều pass.
Done

### So sánh các lựa chọn và để người dùng quyết định

- Ngày feedback: 2026-08-25
- Dự án nguồn: `C:\harness\S_HNess`
- Hiện trạng: Khi một vấn đề có nhiều lựa chọn hợp lý, lifecycle guidance chưa bắt buộc trình bày so sánh và lấy lựa chọn trực tiếp từ người dùng.
- Mong đợi: Mọi quyết định trọng yếu có nhiều phương án phải được so sánh theo tiêu chí phù hợp, nêu trade-off/rủi ro, rồi để người dùng chọn; chỉ dùng quyết định ủy quyền khi người dùng nói rõ.
- Bằng chứng/tái hiện: Phản hồi tiếp theo của người dùng khi cập nhật `s-feedback`.
- Skill/pack ảnh hưởng: `user-design-gate`, `s-discover`, `s-spec`, `s-plan` trong `s-hness-core`.
- Thay đổi: Thêm quy tắc so sánh lựa chọn vào gate dùng chung; discovery/spec/plan đều phải ghi lựa chọn hoặc ủy quyền, và trả `needs_input` khi phương án trọng yếu chưa được chọn.
- Kiểm tra: Harness validator pass với 6 plugin và 29 skill; 8 focused invariants về so sánh phương án, lựa chọn/ủy quyền của người dùng, chặn quyết định chưa hoàn tất, áp dụng qua discovery/spec/plan và giới hạn 10 feedback đều pass.
Done

### Tách plan theo chủ đề thay vì dồn vào một file

- Ngày feedback: 2026-08-25
- Dự án nguồn: `C:\soli`
- Hiện trạng: Khi render plan cho một chủ đề mới, nội dung kế hoạch bị nối thêm vào `plan.md` hiện có, khiến các kế hoạch khác nhau bị dồn chung vào một file.
- Mong đợi: Mỗi kế hoạch độc lập phải được lưu trong một file plan riêng, có tên/đường dẫn phản ánh chủ đề; không cập nhật plan cũ khi bắt đầu chủ đề mới. Chỉ sửa file plan đó khi người dùng yêu cầu thay đổi dựa trên chính plan đó.
- Bằng chứng/tái hiện: `s-plan` được gọi cho kế hoạch image-to-CAD trong workspace đã có roadmap tổng thể; kết quả được chèn thêm vào `C:\soli\plan.md` thay vì tạo artifact kế hoạch riêng.
- Skill/pack ảnh hưởng: `s-plan` trong `s-hness-core`, cùng artifact policy.
- Thay đổi: Chủ đề mới tạo `plans/<topic-slug>.md`; chỉ continuation explicit mới cập nhật plan cũ; collision dùng slug cụ thể hơn; `s-cook` yêu cầu path xác định rõ và không tự chọn `plan.md` hoặc file mới nhất.
- Kiểm tra: quick validator của `s-plan` và `s-cook`, harness validator, plugin validator `s-hness-core` cùng 10 invariant behavior đều pass.
Done

### Báo tiến độ thao tác trong s-run và s-cook

- Ngày feedback: 2026-08-25
- Dự án nguồn: `C:\harness\S_HNess`
- Hiện trạng: Hai skill chủ yếu yêu cầu báo ở đầu hoặc ranh giới pha, chưa bắt buộc mô tả thao tác đáng kể đang diễn ra.
- Mong đợi: Chủ động báo đang làm gì, tác động file nào, đường dẫn nguồn–đích khi di chuyển và bước kế tiếp.
- Bằng chứng/tái hiện: Phản hồi trực tiếp của người dùng trong lúc cập nhật harness.
- Skill/pack ảnh hưởng: `s-run`, `s-cook` trong `s-hness-core`
- Thay đổi: Bắt buộc báo trước và sau thao tác đáng kể, nêu path bị tác động, nguồn–đích khi di chuyển hoặc đổi tên, cùng bước kế tiếp; cho phép nhóm các kiểm tra đọc nhỏ để tránh spam.
- Kiểm tra: quick validator của cả hai skill, harness validator và plugin validator `s-hness-core` đều pass.
Done

### Bắt buộc tổ chức source code dễ bảo trì

- Ngày feedback: 2026-08-25
- Dự án nguồn: `C:\harness\S_HNess`
- Hiện trạng: Các domain skill có hướng dẫn cấu trúc riêng nhưng luồng thực thi chung chưa bắt buộc áp dụng trước khi tạo hoặc sắp xếp lại code.
- Mong đợi: Code, đặc biệt software tool, được đặt trong cấu trúc thư mục rõ trách nhiệm, đúng convention và dễ bảo trì như một dự án chuyên nghiệp.
- Bằng chứng/tái hiện: Phản hồi trực tiếp của người dùng sau khi cập nhật `s-run` và `s-cook`.
- Skill/pack ảnh hưởng: `s-run` trong `s-hness-core`, project-structure guidance trong `s-hness-tools`
- Thay đổi: Thêm source-structure gate vào `s-run`; yêu cầu theo convention hiện có, ownership và dependency rõ ràng, entrypoint mỏng, tách domain khỏi adapter/I/O, không tạo layer rỗng hoặc thư mục tiện ích kiểu dumping ground.
- Kiểm tra: quick validator của `s-run` và `tool-product-design`, harness validator, plugin validator cho `s-hness-core` và `s-hness-tools`, cùng 10 invariant bảo trì đều pass.
Done

### Tách reinstall thành plugin bảo trì riêng

- Ngày feedback: 2026-08-25
- Dự án nguồn: `C:\harness\S_HNess`
- Hiện trạng: Reinstall plugin được thực hiện bằng chuỗi lệnh thủ công trong phiên làm việc.
- Mong đợi: Có plugin chuyên trách chạy một workflow reinstall deterministic thay vì agent tự ghép lệnh.
- Bằng chứng/tái hiện: Phản hồi trực tiếp của người dùng sau các lần refresh plugin.
- Skill/pack ảnh hưởng: Plugin mới `s-hness-maintenance` và skill `s-reinstall`
- Thay đổi: Thêm plugin có script staging, cachebuster, validation, backup, swap, Codex registration, active/cache verification và rollback; skill bắt buộc dry-run cùng approval trước mutation.
- Kiểm tra: PowerShell parser, dry-run success/failure, zero operation-directory delta, quick validator, plugin validator và harness validator đều pass; harness nhận 6 plugin và 29 skill.
- Giới hạn: Lifecycle mutation thật và rollback live chưa chạy theo yêu cầu không tự reinstall; trạng thái phần này là `unverified`. PSScriptAnalyzer không có sẵn và không được cài thêm.
Done

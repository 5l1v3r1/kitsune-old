; RUN: opt < %s -sync-elimination -S | FileCheck %s

; ModuleID = 'basic2.cpp'
source_filename = "basic2.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define void @_Z4funcv() #0 {
; CHECK: @_Z4funcv
entry:
  %syncreg = call token @llvm.syncregion.start()
  detach within %syncreg, label %det.achd, label %det.cont

det.achd:                                         ; preds = %entry
  reattach within %syncreg, label %det.cont

det.cont:                                         ; preds = %det.achd, %entry
; CHECK-NOT: sync within %syncreg, label %sync.continue
  sync within %syncreg, label %sync.continue

; CHECK: sync.continue
sync.continue:                                    ; preds = %det.cont
  sync within %syncreg, label %sync.continue1

sync.continue1:                                   ; preds = %sync.continue
  ret void
}

; Function Attrs: argmemonly nounwind
declare token @llvm.syncregion.start() #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }

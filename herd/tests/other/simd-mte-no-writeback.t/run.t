Keep the previous SIMD micro-operations and dependencies for SP-based accesses.
No-writeback accesses must not gain an MTE tag-check event, while writeback
forms keep their data, memory, and base-register update micro-operations.

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/SIMD-LDR-SP.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid0 [label="a: R[x]q=1\lproc:P0 poi:0\lLDR Q0,[SP]", shape="box", color="blue"];
  eiid1 [label="b: R[x+8]q=2\lproc:P0 poi:0\lLDR Q0,[SP]", shape="box", color="blue"];
  eiid5 [label="f: R0:SPq=x (addr)\lproc:P0 poi:0\lLDR Q0,[SP]", shape="box", color="blue"];
  eiid6 [label="g: W0:V0s=0x20000000000000001\lproc:P0 poi:0\lLDR Q0,[SP]", shape="box", color="blue"];
  eiid7 [label="h: R0:V0s=0x20000000000000001\lproc:P0 poi:1\lMOV X0,V0.D[0]", shape="box", color="blue"];
  eiid8 [label="i: W0:X0q=1\lproc:P0 poi:1\lMOV X0,V0.D[0]", shape="box", color="blue"];
  eiid9 [label="j: R0:V0s=0x20000000000000001\lproc:P0 poi:2\lMOV X1,V0.D[1]", shape="box", color="blue"];
  eiid10 [label="k: W0:X1q=2\lproc:P0 poi:2\lMOV X1,V0.D[1]", shape="box", color="blue"];
  eiid0 -> eiid6 [label="iico_data", color="black", fontcolor="black"];
  eiid1 -> eiid6 [label="iico_data", color="black", fontcolor="black"];
  eiid5 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid5 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid7 -> eiid8 [label="iico_data", color="black", fontcolor="black"];
  eiid9 -> eiid10 [label="iico_data", color="black", fontcolor="black"];
  eiid8 -> eiid9 [label="po", color="black", fontcolor="black"];
  eiid6 -> eiid7 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid6 -> eiid9 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND SIMD-LDR-SP

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/SIMD-STR-SP.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid5 [label="f: R0:X0q=1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid6 [label="g: R0:V0s=0\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid7 [label="h: W0:V0s=0x1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid8 [label="i: R0:X1q=2\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid9 [label="j: R0:V0s=0x1\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid10 [label="k: W0:V0s=0x20000000000000001\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid0 [label="a: W[x]q=1\lproc:P0 poi:2\lSTR Q0,[SP]", shape="box", color="blue"];
  eiid1 [label="b: W[x+8]q=2\lproc:P0 poi:2\lSTR Q0,[SP]", shape="box", color="blue"];
  eiid11 [label="l: R0:SPq=x (addr)\lproc:P0 poi:2\lSTR Q0,[SP]", shape="box", color="blue"];
  eiid12 [label="m: R0:V0s=0x20000000000000001 (data)\lproc:P0 poi:2\lSTR Q0,[SP]", shape="box", color="blue"];
  eiid5 -> eiid6 [label="iico_data", color="black", fontcolor="black"];
  eiid6 -> eiid7 [label="iico_data", color="black", fontcolor="black"];
  eiid8 -> eiid9 [label="iico_data", color="black", fontcolor="black"];
  eiid9 -> eiid10 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid7 -> eiid8 [label="po", color="black", fontcolor="black"];
  eiid10 -> eiid11 [label="po", color="black", fontcolor="black"];
  eiid7 -> eiid9 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid10 -> eiid12 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND SIMD-STR-SP

The previous pair-store graph keeps the second data read dependent on the
address computation, independently of the first data read.

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/SIMD-STP-SP.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid10 [label="k: R0:X0q=1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid11 [label="l: R0:V0s=0\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid12 [label="m: W0:V0s=0x1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid13 [label="n: R0:X1q=2\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid14 [label="o: R0:V0s=0x1\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid15 [label="p: W0:V0s=0x20000000000000001\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid16 [label="q: R0:X2q=3\lproc:P0 poi:2\lMOV V1.D[0],X2", shape="box", color="blue"];
  eiid17 [label="r: R0:V1s=0\lproc:P0 poi:2\lMOV V1.D[0],X2", shape="box", color="blue"];
  eiid18 [label="s: W0:V1s=0x3\lproc:P0 poi:2\lMOV V1.D[0],X2", shape="box", color="blue"];
  eiid19 [label="t: R0:X3q=4\lproc:P0 poi:3\lMOV V1.D[1],X3", shape="box", color="blue"];
  eiid20 [label="u: R0:V1s=0x3\lproc:P0 poi:3\lMOV V1.D[1],X3", shape="box", color="blue"];
  eiid21 [label="v: W0:V1s=0x40000000000000003\lproc:P0 poi:3\lMOV V1.D[1],X3", shape="box", color="blue"];
  eiid0 [label="a: W[x]q=1\lproc:P0 poi:4\lSTP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid1 [label="b: W[x+8]q=2\lproc:P0 poi:4\lSTP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid2 [label="c: W[x+16]q=3\lproc:P0 poi:4\lSTP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid3 [label="d: W[x+24]q=4\lproc:P0 poi:4\lSTP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid22 [label="w: R0:SPq=x (addr)\lproc:P0 poi:4\lSTP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid23 [label="x: R0:V0s=0x20000000000000001 (data)\lproc:P0 poi:4\lSTP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid24 [label="y: R0:V1s=0x40000000000000003 (data)\lproc:P0 poi:4\lSTP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid10 -> eiid11 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid12 [label="iico_data", color="black", fontcolor="black"];
  eiid13 -> eiid14 [label="iico_data", color="black", fontcolor="black"];
  eiid14 -> eiid15 [label="iico_data", color="black", fontcolor="black"];
  eiid16 -> eiid17 [label="iico_data", color="black", fontcolor="black"];
  eiid17 -> eiid18 [label="iico_data", color="black", fontcolor="black"];
  eiid19 -> eiid20 [label="iico_data", color="black", fontcolor="black"];
  eiid20 -> eiid21 [label="iico_data", color="black", fontcolor="black"];
  eiid22 -> eiid23 [label="iico_data", color="black", fontcolor="black"];
  eiid22 -> eiid24 [label="iico_data", color="black", fontcolor="black"];
  eiid23 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid23 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid24 -> eiid2 [label="iico_data", color="black", fontcolor="black"];
  eiid24 -> eiid3 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid13 [label="po", color="black", fontcolor="black"];
  eiid15 -> eiid16 [label="po", color="black", fontcolor="black"];
  eiid18 -> eiid19 [label="po", color="black", fontcolor="black"];
  eiid21 -> eiid22 [label="po", color="black", fontcolor="black"];
  eiid12 -> eiid14 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid15 -> eiid23 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid18 -> eiid20 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid21 -> eiid24 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND SIMD-STP-SP

The pair load keeps the two independent memory reads and destination writes.

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/SIMD-LDP-SP.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid0 [label="a: R[x]q=1\lproc:P0 poi:0\lLDP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid1 [label="b: R[x+8]q=2\lproc:P0 poi:0\lLDP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid2 [label="c: R[x+16]q=3\lproc:P0 poi:0\lLDP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid3 [label="d: R[x+24]q=4\lproc:P0 poi:0\lLDP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid10 [label="k: R0:SPq=x (addr)\lproc:P0 poi:0\lLDP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid11 [label="l: W0:V0s=0x20000000000000001\lproc:P0 poi:0\lLDP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid12 [label="m: W0:V1s=0x40000000000000003\lproc:P0 poi:0\lLDP Q0,Q1,[SP]", shape="box", color="blue"];
  eiid13 [label="n: R0:V0s=0x20000000000000001\lproc:P0 poi:1\lMOV X0,V0.D[0]", shape="box", color="blue"];
  eiid14 [label="o: W0:X0q=1\lproc:P0 poi:1\lMOV X0,V0.D[0]", shape="box", color="blue"];
  eiid15 [label="p: R0:V0s=0x20000000000000001\lproc:P0 poi:2\lMOV X1,V0.D[1]", shape="box", color="blue"];
  eiid16 [label="q: W0:X1q=2\lproc:P0 poi:2\lMOV X1,V0.D[1]", shape="box", color="blue"];
  eiid17 [label="r: R0:V1s=0x40000000000000003\lproc:P0 poi:3\lMOV X2,V1.D[0]", shape="box", color="blue"];
  eiid18 [label="s: W0:X2q=3\lproc:P0 poi:3\lMOV X2,V1.D[0]", shape="box", color="blue"];
  eiid19 [label="t: R0:V1s=0x40000000000000003\lproc:P0 poi:4\lMOV X3,V1.D[1]", shape="box", color="blue"];
  eiid20 [label="u: W0:X3q=4\lproc:P0 poi:4\lMOV X3,V1.D[1]", shape="box", color="blue"];
  eiid0 -> eiid11 [label="iico_data", color="black", fontcolor="black"];
  eiid1 -> eiid11 [label="iico_data", color="black", fontcolor="black"];
  eiid2 -> eiid12 [label="iico_data", color="black", fontcolor="black"];
  eiid3 -> eiid12 [label="iico_data", color="black", fontcolor="black"];
  eiid10 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid10 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid10 -> eiid2 [label="iico_data", color="black", fontcolor="black"];
  eiid10 -> eiid3 [label="iico_data", color="black", fontcolor="black"];
  eiid13 -> eiid14 [label="iico_data", color="black", fontcolor="black"];
  eiid15 -> eiid16 [label="iico_data", color="black", fontcolor="black"];
  eiid17 -> eiid18 [label="iico_data", color="black", fontcolor="black"];
  eiid19 -> eiid20 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid13 [label="po", color="black", fontcolor="black"];
  eiid14 -> eiid15 [label="po", color="black", fontcolor="black"];
  eiid16 -> eiid17 [label="po", color="black", fontcolor="black"];
  eiid18 -> eiid19 [label="po", color="black", fontcolor="black"];
  eiid11 -> eiid13 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid11 -> eiid15 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid12 -> eiid17 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid12 -> eiid19 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND SIMD-LDP-SP

The post-indexed SIMD store retains its split data stores and writeback.

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/SIMD-STR-SP-postindex.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid5 [label="f: R0:X0q=1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid6 [label="g: R0:V0s=0\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid7 [label="h: W0:V0s=0x1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid8 [label="i: R0:X1q=2\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid9 [label="j: R0:V0s=0x1\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid10 [label="k: W0:V0s=0x20000000000000001\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid0 [label="a: W[x:green]q=1\lproc:P0 poi:2\lSTR Q0,[SP],#16", shape="box", color="blue"];
  eiid1 [label="b: W[x:green+8]q=2\lproc:P0 poi:2\lSTR Q0,[SP],#16", shape="box", color="blue"];
  eiid11 [label="l: R0:SPq=x:green (addr)\lproc:P0 poi:2\lSTR Q0,[SP],#16", shape="box", color="blue"];
  eiid12 [label="m: R0:V0s=0x20000000000000001 (data)\lproc:P0 poi:2\lSTR Q0,[SP],#16", shape="box", color="blue"];
  eiid13 [label="n: W0:SPq=x:green+16\lproc:P0 poi:2\lSTR Q0,[SP],#16", shape="box", color="blue"];
  eiid5 -> eiid6 [label="iico_data", color="black", fontcolor="black"];
  eiid6 -> eiid7 [label="iico_data", color="black", fontcolor="black"];
  eiid8 -> eiid9 [label="iico_data", color="black", fontcolor="black"];
  eiid9 -> eiid10 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid13 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid13 [label="iico_data", color="black", fontcolor="black"];
  eiid7 -> eiid8 [label="po", color="black", fontcolor="black"];
  eiid10 -> eiid11 [label="po", color="black", fontcolor="black"];
  eiid7 -> eiid9 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid10 -> eiid12 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND SIMD-STR-SP-postindex

The lane structure load keeps its lane read and vector-register update.

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/LD1-SP.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid0 [label="a: R[x]q=1\lproc:P0 poi:0\lLD1 {V0.D}[0],[SP]", shape="box", color="blue"];
  eiid3 [label="d: R0:SPq=x (addr)\lproc:P0 poi:0\lLD1 {V0.D}[0],[SP]", shape="box", color="blue"];
  eiid4 [label="e: R0:V0s=0\lproc:P0 poi:0\lLD1 {V0.D}[0],[SP]", shape="box", color="blue"];
  eiid5 [label="f: W0:V0s=0x1\lproc:P0 poi:0\lLD1 {V0.D}[0],[SP]", shape="box", color="blue"];
  eiid6 [label="g: R0:V0s=0x1\lproc:P0 poi:1\lMOV X0,V0.D[0]", shape="box", color="blue"];
  eiid7 [label="h: W0:X0q=1\lproc:P0 poi:1\lMOV X0,V0.D[0]", shape="box", color="blue"];
  eiid0 -> eiid4 [label="iico_data", color="black", fontcolor="black"];
  eiid3 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid4 -> eiid5 [label="iico_data", color="black", fontcolor="black"];
  eiid6 -> eiid7 [label="iico_data", color="black", fontcolor="black"];
  eiid5 -> eiid6 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND LD1-SP

The whole-vector structure store keeps the vector read and memory writes.

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/ST1-SP.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid5 [label="f: R0:X0q=1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid6 [label="g: R0:V0s=0\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid7 [label="h: W0:V0s=0x1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid8 [label="i: R0:X1q=2\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid9 [label="j: R0:V0s=0x1\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid10 [label="k: W0:V0s=0x20000000000000001\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid0 [label="a: W[x]q=1\lproc:P0 poi:2\lST1 {V0.2D},[SP]", shape="box", color="blue"];
  eiid1 [label="b: W[x+8]q=2\lproc:P0 poi:2\lST1 {V0.2D},[SP]", shape="box", color="blue"];
  eiid11 [label="l: R0:SPq=x (addr)\lproc:P0 poi:2\lST1 {V0.2D},[SP]", shape="box", color="blue"];
  eiid12 [label="m: R0:V0s=0x20000000000000001 (data)\lproc:P0 poi:2\lST1 {V0.2D},[SP]", shape="box", color="blue"];
  eiid13 [label="n: R0:V0s=0x20000000000000001 (data)\lproc:P0 poi:2\lST1 {V0.2D},[SP]", shape="box", color="blue"];
  eiid5 -> eiid6 [label="iico_data", color="black", fontcolor="black"];
  eiid6 -> eiid7 [label="iico_data", color="black", fontcolor="black"];
  eiid8 -> eiid9 [label="iico_data", color="black", fontcolor="black"];
  eiid9 -> eiid10 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid12 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid13 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid13 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid7 -> eiid8 [label="po", color="black", fontcolor="black"];
  eiid10 -> eiid11 [label="po", color="black", fontcolor="black"];
  eiid7 -> eiid9 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid10 -> eiid12 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid10 -> eiid13 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND ST1-SP

The no-writeback multi-register structure load keeps independent register
results and adds no tag-check micro-op.

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/LD2-SP.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid0 [label="a: R[x]q=1\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid1 [label="b: R[x+8]q=2\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid2 [label="c: R[x+16]q=3\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid3 [label="d: R[x+24]q=4\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid10 [label="k: R0:SPq=x (addr)\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid11 [label="l: R0:V0s=0\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid12 [label="m: W0:V0s=0x1\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid13 [label="n: R0:V1s=0\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid14 [label="o: W0:V1s=0x2\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid15 [label="p: R0:V0s=0x1\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid16 [label="q: W0:V0s=0x30000000000000001\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid17 [label="r: R0:V1s=0x2\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid18 [label="s: W0:V1s=0x40000000000000002\lproc:P0 poi:0\lLD2 {V0.2D, V1.2D},[SP]", shape="box", color="blue"];
  eiid0 -> eiid11 [label="iico_data", color="black", fontcolor="black"];
  eiid1 -> eiid13 [label="iico_data", color="black", fontcolor="black"];
  eiid2 -> eiid15 [label="iico_data", color="black", fontcolor="black"];
  eiid3 -> eiid17 [label="iico_data", color="black", fontcolor="black"];
  eiid10 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid12 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid13 -> eiid14 [label="iico_data", color="black", fontcolor="black"];
  eiid14 -> eiid2 [label="iico_data", color="black", fontcolor="black"];
  eiid15 -> eiid16 [label="iico_data", color="black", fontcolor="black"];
  eiid16 -> eiid3 [label="iico_data", color="black", fontcolor="black"];
  eiid17 -> eiid18 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid15 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid14 -> eiid17 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND LD2-SP

The post-indexed multi-register structure store keeps its source reads,
interleaved memory writes, and base-register update.

  $ herd7 -set-libdir ../libdir ../../instructions/AArch64.MTE/ST2-SP-postindex.litmus -show all -showevents all -showinitwrites false -o - | sed -n '/^digraph G {/,/^DOTEND/p' | grep -E '^(eiid[0-9]+ \[label=|eiid[0-9]+ ->|DOTEND)'
  eiid10 [label="k: R0:X0q=1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid11 [label="l: R0:V0s=0\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid12 [label="m: W0:V0s=0x1\lproc:P0 poi:0\lMOV V0.D[0],X0", shape="box", color="blue"];
  eiid13 [label="n: R0:X1q=2\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid14 [label="o: R0:V0s=0x1\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid15 [label="p: W0:V0s=0x20000000000000001\lproc:P0 poi:1\lMOV V0.D[1],X1", shape="box", color="blue"];
  eiid16 [label="q: R0:X2q=3\lproc:P0 poi:2\lMOV V1.D[0],X2", shape="box", color="blue"];
  eiid17 [label="r: R0:V1s=0\lproc:P0 poi:2\lMOV V1.D[0],X2", shape="box", color="blue"];
  eiid18 [label="s: W0:V1s=0x3\lproc:P0 poi:2\lMOV V1.D[0],X2", shape="box", color="blue"];
  eiid19 [label="t: R0:X3q=4\lproc:P0 poi:3\lMOV V1.D[1],X3", shape="box", color="blue"];
  eiid20 [label="u: R0:V1s=0x3\lproc:P0 poi:3\lMOV V1.D[1],X3", shape="box", color="blue"];
  eiid21 [label="v: W0:V1s=0x40000000000000003\lproc:P0 poi:3\lMOV V1.D[1],X3", shape="box", color="blue"];
  eiid0 [label="a: W[x:green]q=1\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid1 [label="b: W[x:green+8]q=3\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid2 [label="c: W[x:green+16]q=2\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid3 [label="d: W[x:green+24]q=4\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid22 [label="w: R0:SPq=x:green (addr)\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid23 [label="x: R0:V0s=0x20000000000000001 (data)\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid24 [label="y: R0:V1s=0x40000000000000003 (data)\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid25 [label="z: R0:V0s=0x20000000000000001 (data)\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid26 [label="ev26: R0:V1s=0x40000000000000003 (data)\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid27 [label="ev27: W0:SPq=x:green+32\lproc:P0 poi:4\lST2 {V0.2D, V1.2D},[SP],#32", shape="box", color="blue"];
  eiid10 -> eiid11 [label="iico_data", color="black", fontcolor="black"];
  eiid11 -> eiid12 [label="iico_data", color="black", fontcolor="black"];
  eiid13 -> eiid14 [label="iico_data", color="black", fontcolor="black"];
  eiid14 -> eiid15 [label="iico_data", color="black", fontcolor="black"];
  eiid16 -> eiid17 [label="iico_data", color="black", fontcolor="black"];
  eiid17 -> eiid18 [label="iico_data", color="black", fontcolor="black"];
  eiid19 -> eiid20 [label="iico_data", color="black", fontcolor="black"];
  eiid20 -> eiid21 [label="iico_data", color="black", fontcolor="black"];
  eiid22 -> eiid23 [label="iico_data", color="black", fontcolor="black"];
  eiid22 -> eiid24 [label="iico_data", color="black", fontcolor="black"];
  eiid22 -> eiid25 [label="iico_data", color="black", fontcolor="black"];
  eiid22 -> eiid26 [label="iico_data", color="black", fontcolor="black"];
  eiid22 -> eiid27 [label="iico_data", color="black", fontcolor="black"];
  eiid23 -> eiid0 [label="iico_data", color="black", fontcolor="black"];
  eiid24 -> eiid1 [label="iico_data", color="black", fontcolor="black"];
  eiid25 -> eiid2 [label="iico_data", color="black", fontcolor="black"];
  eiid26 -> eiid3 [label="iico_data", color="black", fontcolor="black"];
  eiid12 -> eiid13 [label="po", color="black", fontcolor="black"];
  eiid15 -> eiid16 [label="po", color="black", fontcolor="black"];
  eiid18 -> eiid19 [label="po", color="black", fontcolor="black"];
  eiid21 -> eiid22 [label="po", color="black", fontcolor="black"];
  eiid12 -> eiid14 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid15 -> eiid23 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid15 -> eiid25 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid18 -> eiid20 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid21 -> eiid24 [label="rf-reg", color="brown", fontcolor="brown"];
  eiid21 -> eiid26 [label="rf-reg", color="brown", fontcolor="brown"];
  DOTEND ST2-SP-postindex

/*
REQUIRED_ARGS: -vcg-ast -o-
PERMUTE_ARGS:
OUTPUT_FILES: compilable/vcg-ast.d.cg
EXTRA_FILES: imports/vcg_ast_import.d
TEST_OUTPUT_FILE: extra-files/vcg-ast.d.cg
// size_t currently must be ulong in this test, not uint
DISABLED: freebsd32 openbsd32 linux32 osx32 win32
*/

module vcg;

alias xyz = __traits(parent, {});
alias named = vcg;

template Seq(A...)
{
    alias Seq = A;
}

auto a = Seq!(1,2,3);


template R(T)
{
  struct _R { T elem; }
}

typeof(R!int._R.elem) x;


static foreach(enum i; 0..3)
{
    mixin("int a" ~ i.stringof ~ " = 1;");
}

void foo()
{
    static foreach(enum i; 0..3)
    {
        mixin("int a" ~ i.stringof ~ " = 1;");
    }
}

class C
{
    invariant {}
    invariant (true);

    int foo() in{} out{} out(r){} in(true) out(; true) out(r; true)
    {
        return 2;
    }
}

enum __c_wchar_t : dchar;
alias wchar_t = __c_wchar_t;

T[] values(T)()
{
    T[] values = [T()];
    return values;
}

void main()
{
    values!wchar_t;
}

// https://issues.dlang.org/show_bug.cgi?id=24764

import imports.vcg_ast_import;

template imported()
{
    import imported = imports.vcg_ast_import;
}

alias myImport = imported!();

// https://github.com/dlang/dmd/issues/21105

enum compiles = __traits(compiles,{
    int[] arr;
    arr ~= 1;
});
enum isexp = is(typeof({
    int[] arr;
    arr ~= 1;
}));

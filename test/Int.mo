import FmtInt "../src/Int";

assert(FmtInt.Parse("100_000", 10) == #ok(100_000));
assert(FmtInt.Parse("+100_000", 10) == #ok(100_000));
assert(FmtInt.Parse("-100_000", 10) == #ok(-100_000));

assert(FmtInt.Parse("-100", 10) == #ok(-100));
assert(FmtInt.Parse("-100", 8) == #ok(-64));
assert(FmtInt.Parse("-100", 2) == #ok(-4));

assert(FmtInt.Format(-4, 2) == "-100");
assert(FmtInt.Format(-64, 8) == "-100");
assert(FmtInt.Format(-100, 10) == "-100");

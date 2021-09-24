import FmtNat "../src/Nat";

assert(FmtNat.ParseNat("100", 10) == #ok(100));
assert(FmtNat.ParseNat("100", 8) == #ok(64));
assert(FmtNat.ParseNat("100", 2) == #ok(4));

assert(FmtNat.FormatNat(4, 2) == "100");
assert(FmtNat.FormatNat(64, 8) == "100");
assert(FmtNat.FormatNat(100, 10) == "100");

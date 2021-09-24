import FmtNat "../src/Nat";

assert(FmtNat.Parse("100_000", 10) == #ok(100_000));

assert(FmtNat.Parse("100", 10) == #ok(100));
assert(FmtNat.Parse("100", 8) == #ok(64));
assert(FmtNat.Parse("100", 2) == #ok(4));

assert(FmtNat.Format(4, 2) == "100");
assert(FmtNat.Format(64, 8) == "100");
assert(FmtNat.Format(100, 10) == "100");

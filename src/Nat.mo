import Array "mo:base/Array";
import Char "mo:base/Char";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Result "mo:base/Result";

import P "mo:base/Prelude";

import Debug "mo:base/Debug";

module {
    public func ParseNat(t : Text, base : Nat) : Result.Result<Nat, Text> {
        if (t == "")                     return #err("text must be non-empty");
        if (base < 2 or 36 < base)       return #err("invalid base: " # Nat.toText(base));

        var n : Nat = 0;
        for (c in t.chars()) {
            if (c != '_') {
                if (c < '0' or '9' < c) return #err("invalid char: " # Char.toText(c));
                let d = charToNat(c) - charToNat('0') : Nat;
                if (base < d) return #err("base (" # Nat.toText(base) # ") smaller than char: " # Char.toText(c));
                n *= base;
                n += d;
            };
        };
        #ok(n);
    };

    public func FormatNat(n : Nat, base : Nat) : Text {
        var s = "";
        var bs : [Nat] = []; 
        var u = n;
        while (base <= u) {
            let q = u / base;
            switch (u - q * base : Nat) {
                case (0) { s := "0" # s; };
                case (1) { s := "1" # s; };
                case (_) { P.unreachable(); };
            };
            u := q;
        };
        switch (u) {
            case (0) { s := "0" # s; };
            case (1) { s := "1" # s; };
            case (_) { P.unreachable(); };
        };
        s;
    };

    private func charToNat(c : Char) : Nat {
        Nat32.toNat(Char.toNat32(c));
    };
};

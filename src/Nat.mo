import Array "mo:base-0.7.3/Array";
import Char "mo:base-0.7.3/Char";
import Nat "mo:base-0.7.3/Nat";
import Nat8 "mo:base-0.7.3/Nat8";
import Nat32 "mo:base-0.7.3/Nat32";
import Result "mo:base-0.7.3/Result";

import P "mo:base-0.7.3/Prelude";

import Debug "mo:base-0.7.3/Debug";

module {
    public func Parse(t : Text, base : Nat) : Result.Result<Nat, Text> {
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

    public func Format(n : Nat, base : Nat) : Text {
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

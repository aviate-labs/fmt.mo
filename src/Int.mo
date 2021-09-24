import Int "mo:base/Int";
import Result "mo:base/Result";
import Text "mo:base/Text";

import FmtNat "Nat"

module {
    public func Parse(t : Text, base : Nat) : Result.Result<Int, Text> {
        var neg = false;
        var n = switch (Text.stripStart(t, #char('+'))) {
            case (null) { t; };
            case (? t)  { t; };
        };
        let nt = switch (Text.stripStart(t, #char('-'))) {
            case (? t)  { 
                neg := true;
                t;
            };
            case (null) {
                switch (Text.stripStart(t, #char('+'))) {
                    case (null) { t; };
                    case (? t)  { t; };
                };
            };
        };
        switch (FmtNat.Parse(nt, base)) {
            case (#err(e)) { #err(e); };
            case (#ok(n))  {
                let i : Int = n;
                if (neg) { #ok(-i); }
                else     { #ok(i);  };
            };
        };
    };

    public func Format(i : Int, base : Nat) : Text {
        let n = FmtNat.Format(Int.abs(i), base);
        if (i < 0) { "-" # n; }
        else       { n;       };
    };
};

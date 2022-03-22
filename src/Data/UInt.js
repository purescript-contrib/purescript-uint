export function from(val) {
    return val >>> 0;
}

export function exact(just) {
    return function (nothing) {
        return function (conv) {
            return function (val) {
                var cval = conv(val);
                if (cval == val) {
                    return just(cval);
                }
                return nothing;
            };
        };
    };
}

export function toInt(uval) {
    return uval | 0;
}

export function toNumber(uval) {
    return uval;
}

export function uintAdd(x) {
    return function (y) {
        return (x + y) >>> 0;
    };
}

export function uintMul(x) {
    return function (y) {
        return Math.imul(x, y) >>> 0;
    };
}

export function uintSub(x) {
    return function (y) {
        return (x - y) >>> 0;
    };
}

export function uintDiv(x) {
    return function (y) {
        return (x / y) >>> 0;
    };
}

export function uintMod(x) {
    return function (y) {
        return (x % y) >>> 0;
    };
}

export function uintDegree(x) {
    return Math.abs(x | 0);
}

export function uintEq(x) {
    return function (y) {
        return x == y;
    };
}

export function uintCmp(lt) {
    return function (eq) {
        return function (gt) {
            return function (x) {
                return function (y) {
                    if (x < y) return lt;
                    if (x === y) return eq;
                    return gt;
                };
            };
        };
    };
}

export function fromStringImpl(s) {
    var n = Number(s);
    if (n === parseInt(s)) {
        return n;
    }
    return NaN;
}

export function toString(x) {
    return x.toString();
}

export function pow(u) {
    return function (p) {
        return Math.pow(u, p) >>> 0;
    };
}

export function and(n1) {
    return function (n2) {
        return (n1 & n2) >>> 0;
    };
}

export function or(n1) {
    return function (n2) {
        return (n1 | n2) >>> 0;
    };
}

export function xor(n1) {
    return function (n2) {
        return (n1 ^ n2) >>> 0;
    };
}

export function shl(n1) {
    return function (n2) {
        return (n1 << n2) >>> 0;
    };
}

export function shr(n1) {
    return function (n2) {
        return (n1 >> n2) >>> 0;
    };
}

export function zshr(n1) {
    return function (n2) {
        return (n1 >>> n2) >>> 0;
    };
}

export function complement(n) {
    return (~n >>> 0);
}

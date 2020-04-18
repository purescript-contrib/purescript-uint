"use strict";

exports.from = function (val) {
    return val >>> 0;
};

exports.exact = function (just) {
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
};

exports.toInt = function (uval) {
    return uval | 0;
};

exports.toNumber = function (uval) {
    return uval;
};

exports.uintAdd = function (x) {
    return function (y) {
        return (x + y) >>> 0;
    };
};

exports.uintMul = function (x) {
    return function (y) {
        return Math.imul(x, y) >>> 0;
    };
};

exports.uintSub = function (x) {
    return function (y) {
        return (x - y) >>> 0;
    };
};

exports.uintDiv = function (x) {
    return function (y) {
        return (x / y) >>> 0;
    };
};

exports.uintMod = function (x) {
    return function (y) {
        return (x % y) >>> 0;
    };
};

exports.uintDegree = function (x) {
    return Math.abs(x | 0);
};

exports.uintEq = function (x) {
    return function (y) {
        return x == y;
    };
};

exports.uintCmp = function (lt) {
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
};

exports.fromStringImpl = function (s) {
    var n = Number(s);
    if (n === parseInt(s)) {
        return n;
    }
    return NaN;
};

exports.toString = function (x) {
    return x.toString();
};

exports.pow = function (u) {
    return function (p) {
        return Math.pow(u, p) >>> 0;
    };
};

exports.and = function (n1) {
    return function (n2) {
        return (n1 & n2) >>> 0;
    };
};

exports.or = function (n1) {
    return function (n2) {
        return (n1 | n2) >>> 0;
    };
};

exports.xor = function (n1) {
    return function (n2) {
        return (n1 ^ n2) >>> 0;
    };
};

exports.shl = function (n1) {
    return function (n2) {
        return (n1 << n2) >>> 0;
    };
};

exports.shr = function (n1) {
    return function (n2) {
        return (n1 >> n2) >>> 0;
    };
};

exports.zshr = function (n1) {
    return function (n2) {
        return (n1 >>> n2) >>> 0;
    };
};

exports.complement = function (n) {
    return (~n >>> 0);
};

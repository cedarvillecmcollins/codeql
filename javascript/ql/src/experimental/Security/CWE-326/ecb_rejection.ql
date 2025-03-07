/**
 * @name ECBRejection
 * @kind problem
 * @description Locates calls to a weak block mode being used in a Cryptographic Operation.
 * @id js/ecb_rejection
 * @tags security
 *       external/cwe/cwe-326
 */

import javascript

class WeakBlockMode extends BlockMode {
  WeakBlockMode() {
    exists(CryptographicOperation application |
      application.getBlockMode().isWeak() and
      this = application.getBlockMode()
    )
  }
}

from BlockMode bm, WeakBlockMode wbm, CryptographicOperation op
where
  op.getBlockMode() = bm and
  bm = wbm
/*
 * select "A weak block cipher mode like " + bm +
 *    " does not secure sensitive data. The data is encoded with the weak block cipher in $@. Make sure it is not sensitive data.",
 *  op, "this cryptographic operation"
 */

select op,
  "This cryptographic operation uses the weak cipher mode " + bm +
    ". Make sure it is not used on sensitive data."

export const idlFactory = ({ IDL }) => {
  const AuditRecord = IDL.Record({
    'productId' : IDL.Text,
    'productName' : IDL.Text,
    'manuId' : IDL.Text,
  });
  const SellerRecord = IDL.Record({
    'sellerName' : IDL.Text,
    'manuId' : IDL.Text,
    'sellerId' : IDL.Text,
  });
  const SellerToConsumerRecord = IDL.Record({
    'productId' : IDL.Text,
    'productName' : IDL.Text,
    'sellerName' : IDL.Text,
    'manuId' : IDL.Text,
    'sellerId' : IDL.Text,
    'consumerId' : IDL.Text,
  });
  return IDL.Service({
    'AddProduct' : IDL.Func([AuditRecord], [IDL.Text], []),
    'AddSeller' : IDL.Func([SellerRecord], [IDL.Text], []),
    'ProductHistory' : IDL.Func([IDL.Text], [IDL.Text], []),
    'ProductVerification' : IDL.Func([IDL.Text, IDL.Text], [IDL.Text], []),
    'SellProductToConsumer' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Text],
        [IDL.Text],
        [],
      ),
    'SellProductToSeller' : IDL.Func([IDL.Text, IDL.Text], [IDL.Text], []),
    'genereteQrcode' : IDL.Func([IDL.Text], [IDL.Text], []),
    'getCompSoldRecords' : IDL.Func(
        [],
        [IDL.Vec(SellerToConsumerRecord)],
        ['query'],
      ),
    'getSellers' : IDL.Func([IDL.Text], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };

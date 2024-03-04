import type { Principal } from '@dfinity/principal';
export interface AuditRecord {
  'productId' : string,
  'productName' : string,
  'manuId' : string,
}
export interface SellerRecord {
  'sellerName' : string,
  'manuId' : string,
  'sellerId' : string,
}
export interface SellerToConsumerRecord {
  'productId' : string,
  'productName' : string,
  'sellerName' : string,
  'manuId' : string,
  'sellerId' : string,
  'consumerId' : string,
}
export interface _SERVICE {
  'AddProduct' : (arg_0: AuditRecord) => Promise<string>,
  'AddSeller' : (arg_0: SellerRecord) => Promise<string>,
  'ProductHistory' : (arg_0: string) => Promise<string>,
  'ProductVerification' : (arg_0: string, arg_1: string) => Promise<string>,
  'SellProductToConsumer' : (
      arg_0: string,
      arg_1: string,
      arg_2: string,
    ) => Promise<string>,
  'SellProductToSeller' : (arg_0: string, arg_1: string) => Promise<string>,
  'genereteQrcode' : (arg_0: string) => Promise<string>,
  'getCompSoldRecords' : () => Promise<Array<SellerToConsumerRecord>>,
  'getSellers' : (arg_0: string) => Promise<string>,
}

import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import List "mo:base/List";
import Array "mo:base/Array";
import Time "mo:base/Time";
import Buffer "mo:base/Buffer";

actor manufacturer{
    // Define the type for an audit record
    public type AuditRecord = {
        productId : Text;
        productName : Text;
        manuId : Text;
    };

    // Define a shared variable to store audit records
    stable var auditRecords : [AuditRecord] = [];
    stable var productIds : [Text] = [];
    stable var manuIdsP : [Text]=[];
    stable var productNames : [Text]=[];
    // Function to append a new audit record
    public func AddProduct(newRecord : AuditRecord) : async Text {
      var id : Text = newRecord.productId;
      var c:Nat=0;
      for (value in productIds.vals()){
          if(id==value){
            c:=1
          }
        };
      if(c!=1){
          // If productId doesn't exist, append the new record to the list
          auditRecords := Array.append(auditRecords, [newRecord]);
          // Append the productId to the productIds list
          productIds := Array.append(productIds, [newRecord.productId]);
          manuIdsP := Array.append(manuIdsP,[newRecord.manuId]);
          productNames:=Array.append(productNames,[newRecord.productName]);
          return "product added successfully under manufacturer "#newRecord.manuId;
      }else {
          return "product id already exists"; 
      }
    };

    public type SellerRecord = {
        sellerId : Text;
        sellerName : Text;
        manuId : Text;
    };

    // Define a shared variable to store audit records
    stable var sellerRecords : [SellerRecord] = [];
    stable var sellerIds : [Text] = [];
    stable var sellerNames : [Text]=[];
    stable var manuIdsS : [Text]=[];


    public func AddSeller(newRecord : SellerRecord) : async Text{
        var id : Text = newRecord.sellerId;
        var mid: Text= newRecord.manuId;
        var d:Nat=0;
        var c:Nat=0;
        for (value in sellerIds.vals()){
            if(id==value){
                c:=1
            }
        };
        for(value in manuIdsP.vals()){
            if(mid==value){
                d:=1
            }
        };
        if(c!=1){
            if(d==1){
            // If productId doesn't exist, append the new record to the list
                sellerRecords := Array.append(sellerRecords, [newRecord]);
                // Append the productId to the productIds list
                sellerIds := Array.append(sellerIds, [newRecord.sellerId]);
                sellerNames := Array.append(sellerNames,[newRecord.sellerName]);
                manuIdsS := Array.append(manuIdsS,[newRecord.manuId]);

                return "seller added successfully under the manufacturer " #newRecord.manuId;
            }else{
                return "Manufacturer doesnot exist with the name "#newRecord.manuId;
            }
        }else {
            return "seller id already exists"; 
        };



    };
    public type ProductToSellerRecord = {
        productId:Text;
        sellerId : Text;
        productName:Text;
        sellerName : Text;
        manuId : Text;
    };
    stable var productsellerRecords : [ProductToSellerRecord] = [];
    stable var soldproductIds : [Text] = [];
    stable var soldSellerIds:[Text]=[];
    // stable var soldprdctnames:[Text]=[];
    // stable var soldsellernames:[Text]=[];
    // stable var soldmanuids:[Text]=[];
    public func SellProductToSeller(prdctId : Text,slrid: Text) : async Text{
        var t:Nat=0;
        for (value in soldproductIds.vals()){
            if(prdctId==value){
                t:=1
            }
        };
        var pi:Int=0;
        var si:Int=0;
        var pf:Int=0;
        var sf:Int=0;
        var pIndex:Int=pi;
        var sIndex:Int=si;
        for(value in productIds.vals()){
            if(value==prdctId){
                pf:=1;
                pIndex:=pi
            }else{
                pi+=1
            }
        };
        for(value in sellerIds.vals()){
            if(value==slrid){
                sf:=1;
                sIndex:=si
            }else{
                si+=1
            }
        };
        // var pIndex:Int=pi;
        // var sIndex:Int=si;
        var pmid="";
        var smid="";
        var pname="";
        var sname="";
        if(pIndex<=productIds.size()-1 ){
            for (i in Iter.range(0, productIds.size())) {
                if(i==pIndex){
                    pname:=productNames[i];
                    pmid:=manuIdsP[i];
                };
            };
        };
        if(sIndex<=sellerIds.size()-1 ){
            for (j in Iter.range(0, sellerIds.size())) {
                if(j==sIndex){
                    sname:=sellerNames[j];
                    smid:=manuIdsS[j];
                };
            };
        };
        if(t==0){
            if(pIndex<=productIds.size()-1 and pf==1){
                if(sIndex<=sellerIds.size()-1 and sf==1){
                    if(pmid==smid){
                        let newRecord : ProductToSellerRecord = {
                                productId = prdctId;
                                sellerId = slrid;
                                productName = pname;
                                sellerName = sname;
                                manuId = smid;
                            };
                            // soldmanuids:=Array.append(soldmanuids,[newRecord.manuId]);
                            // soldprdctnames:=Array.append(soldprdctnames,[newRecord.productName]);
                            // soldsellernames:=Array.append(soldsellernames,[newRecord.sellerName]);
                            soldSellerIds:=Array.append(soldSellerIds,[newRecord.sellerId]);
                            soldproductIds:=Array.append(soldproductIds,[newRecord.productId]);
                            productsellerRecords := Array.append(productsellerRecords,[newRecord]);
                            return ("Product sold to the Seller");
                    }else{
                            return "There is no seller with that sellerId under the manufacturer";
                        }
                    }else{
                        return "SellerId doesnot exist";
                    }
                }else{
                    return "ProductId doesnot exist";
                }
            }else{
                return "The product with Product Id already sold to the Seller";
        };
    };
    public type SellerToConsumerRecord = {
        productId:Text;
        sellerId : Text;
        productName:Text;
        sellerName : Text;
        manuId : Text;
        consumerId: Text;
    };
    stable var sellerconsumerRecords : [SellerToConsumerRecord] = [];
    stable var compsold:[Text]=[];
    stable var compsoldc:[Text]=[];
    public func SellProductToConsumer(prdid : Text,slrdid : Text, cnsrid : Text):async Text{
        var t:Nat=0;
        for (value in compsold.vals()){
            if(prdid==value){
                t:=1
            }
        };
        var sf:Int=0;
        var sIndex:Nat=0;
        var si:Nat=0;
        var pd:Nat=0;
        var pi:Nat=0;
        var pIndex:Nat=0;
        var sn:Nat=0;
        var sna:Nat=0;
        var snIndex:Nat=0;
        if(t==0){
            for(value in productIds.vals()){
                if(value==prdid){
                    pd:=1;
                    pIndex:=pi;
                }else{
                    pi+=1;
                }
            };
            if(pd==1){
                for(value in soldproductIds.vals()){
                    if(value==prdid){
                        sf:=1;
                        sIndex:=si;
                    }else{
                        si+=1;
                    }
                };
                if(sf==1){
                    if(slrdid==soldSellerIds[sIndex]){
                        for(value in sellerIds.vals()){
                            if(value==slrdid){
                                sn:=1;
                                snIndex:=sna;
                            }else{
                                sna+=1;
                            }
                        };
                        let pname=productNames[pIndex];
                        let sname=sellerNames[snIndex];
                        let smid=manuIdsP[pIndex];
                        let newRecord : SellerToConsumerRecord = {
                            productId=prdid;
                            sellerId=slrdid;
                            productName=pname;
                            sellerName=sname;
                            manuId=smid;
                            consumerId=cnsrid;
                        };
                        sellerconsumerRecords := Array.append(sellerconsumerRecords,[newRecord]);
                        compsold:=Array.append(compsold,[prdid]);
                        compsoldc:=Array.append(compsoldc,[cnsrid]);
                        return "Product sold to the consumer by the seller ";
                    }else{
                        return "Seller Id not Matched";
                    }
                }else{
                    return "Product is not sold to the seller by the manufaturer";
                }
            }else{
                return "Product Id doesnot exist";
            }
        }else{
            return "Product has already been sold";
        }

    };
    public func ProductVerification(prdid : Text,csrid :Text):async Text{
        var sf:Int=0;
        var sIndex:Nat=0;
        var si:Nat=0;
        var pd:Nat=0;
        for(value in soldproductIds.vals()){
            if(value==prdid){
                sf:=1;
                sIndex:=si;
            }else{
                si+=1;
            }
        };
        if(sf==1){
            if(compsoldc[sIndex]==csrid){
                return "Genuine Product";
            }else{
                return "Fake Product";
            }
        }else{
            return "Fake Product";
        }
    };
    public func ProductHistory(prdid:Text): async Text{
        var sf:Int=0;
        var sIndex:Nat=0;
        var ss:Int=0;
        var ssIndex:Nat=0;
        var si:Nat=0;
        var pd:Nat=0;
        var pIndex:Nat=0;
        var pi:Nat=0;
        var sp:Nat=0;
        var spn:Nat=0;
        var ssn:Int=0;
        var ssnIndex:Nat=0;
        for(value in productIds.vals()){
            if(value==prdid){
                pd:=1;
                pIndex:=pi;
            }else{
                pi+=1;
            }
        };
        if(pd==1){
            for(value in soldproductIds.vals()){
                if(value==prdid){
                    ss:=1;
                    ssIndex:=si;
                }else{
                    sp+=1;
                }
            };
            if(ss==1){
                for(value in sellerIds.vals()){
                    if(value==soldSellerIds[ssIndex]){
                        ssn:=1;
                        ssnIndex:=si;
                    }else{
                        spn+=1;
                    }
                };
                for(value in compsold.vals()){
                    if(value==prdid){
                        sf:=1;
                        sIndex:=si;
                    }else{
                        si+=1;
                    }
                };
                if(sf==1){
                    return(" Product Id: "# prdid # 
                    " Seller Id : " #soldSellerIds[ssIndex]# 
                    " Consumer Id : " #compsoldc[sIndex]#
                    " Seller Name : " #sellerNames[ssnIndex] #
                    " Product Name : " #productNames[pIndex] #
                    " Manufacture Id : "#manuIdsP[pIndex]);
                }else{
                    return (" Product Id: " # prdid # 
                    " Seller Id : " #soldSellerIds[ssIndex]# 
                    " Seller Name : " #sellerNames[ssnIndex] #
                    " Product Name : " #productNames[pIndex] #
                    " Manufacture Id : "#manuIdsP[pIndex]);
                }
            }else{
                return (" Product Id: " # prdid # 
                    " Product Name : " #productNames[pIndex] #
                    " Manufacture Id : "#manuIdsP[pIndex]);
            }
        }else{
            return "Product Doesnot Exist";
        }

    };
//     // Function to get all audit records
//     public query func getAuditRecords() : async [AuditRecord] {
//         return auditRecords;
//     };
    public func getSellers(manuid: Text): async Text {
        var manuseller:[Nat]=[];
        var pd:Nat=0;
        var pIndex:Nat=0;
        var data:Text="";
        var pi:Nat=0;
        for(value in manuIdsS.vals()){
            if(value==manuid){
                pd:=1;
                manuseller:=Array.append(manuseller,[pi]);
                pi+=1;
            }else{
                pi+=1;
            }
        };
        if(pd==1){
            var i:Nat=0;
            while (i < manuseller.size()) {
                Debug.print(debug_show(manuseller));
                Debug.print(debug_show(sellerNames));
                Debug.print(debug_show(sellerIds));
                let index = manuseller[i];
                let sellerIdText = sellerIds[index];
                data #= sellerNames[index] # " " # sellerIdText # " ; ";
                Debug.print(debug_show(data));
                i += 1;
            };
            // for (i in Iter.range(0, manuseller.size())) {
            //     let index = manuseller[i];
            //     let sellerIdText = Nat.toText(sellerIds[index]);
            //     data #= sellerNames[index] # " " # sellerIdText;
            //     p+=index;
            //     r#=sellerIdText;

            //     Debug.print(debug_show(data));
            // };
            return data;
        }else{
            return "no manufacturer exist";
        }
    };
    public func genereteQrcode(productId:Text):async Text{
        var url:Text="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data="#productId;
        return url;
    };

    public query func getCompSoldRecords() : async[SellerToConsumerRecord]{
        return sellerconsumerRecords;
        
    };
    // public func handleRequest(request: Http.Request) : async Http.Response {
    //     switch (request.url.path) {
    //         case ("/")
    //             return Http.Response.ok({ body = Text.encodeUtf8("This is index.html"); headers = [] });
    //         case ("/manf")
    //             return Http.Response.ok({ body = Text.encodeUtf8("This is manf.html"); headers = [] });
    //         case ()
    //             return Http.Response.notFound({ body = Text.encodeUtf8("404 Not Found"); headers = [] });
    //     };
    // };

    // public query func getSoldRecords() : async [ProductToSellerRecord] {
    //     return productsellerRecords;
    // };
    // public query func getProductIds() : async [Nat] {
    //     return productIds;
    // };
    // public query func getProductNames() : async [Text] {
    //     return productNames;
    // };
    // public query func getmanuIds() : async [Text] {
    //     return manuIdsP;
    // };
    // public query func getsellerIds() : async [Nat] {
    //     return sellerIds;
    // };
    // public query func getsellerNames() : async [Text] {
    //     return sellerNames;
    // };
    // public query func getmanuIdss() : async [Text] {
    //     return manuIdsS;
    // }
}
  
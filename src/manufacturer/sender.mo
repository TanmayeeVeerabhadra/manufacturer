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
        productId : Nat;
        productName : Text;
        manuId : Text;
    };

    // Define a shared variable to store audit records
    stable var auditRecords : [AuditRecord] = [];
    stable var productIds : [Nat] = [];
    stable var manuIdsP : [Text]=[];
    stable var productNames : [Text]=[];
    // Function to append a new audit record
    public func AddProduct(newRecord : AuditRecord) : async Text {
      var id : Nat = newRecord.productId;
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
        sellerId : Nat;
        sellerName : Text;
        manuId : Text;
    };

    // Define a shared variable to store audit records
    stable var sellerRecords : [SellerRecord] = [];
    stable var sellerIds : [Nat] = [];
    stable var sellerNames : [Text]=[];
    stable var manuIdsS : [Text]=[];


    public func AddSeller(newRecord : SellerRecord) : async Text{
        var id : Nat = newRecord.sellerId;
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
        productId:Nat;
        sellerId : Nat;
        productName:Text;
        sellerName : Text;
        manuId : Text;
    };
    stable var productsellerRecords : [ProductToSellerRecord] = [];
    stable var soldproductIds : [Nat] = [];
    stable var soldSellerIds:[Nat]=[];
    stable var soldprdctnames:[Text]=[];
    stable var soldsellernames:[Text]=[];
    stable var soldmanuids:[Text]=[];
    public func SellProductToSeller(prdctId : Nat,slrid: Nat) : async Text{
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
                            soldmanuids:=Array.append(soldmanuids,[newRecord.manuId]);
                            soldprdctnames:=Array.append(soldprdctnames,[newRecord.productName]);
                            soldsellernames:=Array.append(soldsellernames,[newRecord.sellerName]);
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
        productId:Nat;
        sellerId : Nat;
        productName:Text;
        sellerName : Text;
        manuId : Text;
        consumerId: Nat;
    };
    stable var sellerconsumerRecords : [SellerToConsumerRecord] = [];
    stable var compsold:[Nat]=[];
    stable var compsoldc:[Nat]=[];
    public func SellProductToConsumer(prdid : Nat,cnsrid : Nat):async Text{
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
        for(value in soldproductIds.vals()){
            if(value==prdid){
                sf:=1;
                sIndex:=si;
            }else{
                si+=1;
            }
        };
        for(value in productIds.vals()){
            if(value==prdid){
                pd:=1;
            }
        };
        if(t==0){
            if(pd==1){
                if(sf==1){
                    let slrid=soldSellerIds[sIndex];
                    let pname=soldprdctnames[sIndex];
                    let sname=soldsellernames[sIndex];
                    let smid=soldmanuids[sIndex];
                    let newRecord : SellerToConsumerRecord = {
                        productId=prdid;
                        sellerId=slrid;
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
                return "Product is not sold to the seller by the manufaturer";
                }
            }else{
                return "Product Id doesnot exist";
            }
        }else{
            return "Product has already been sold";
        }

    };
    public func ProductVerification(prdid : Nat,cnsrid :Nat):async Text{
        var sf:Int=0;
        var sIndex:Nat=0;
        var si:Nat=0;
        var pd:Nat=0;
        for(value in compsold.vals()){
            if(value==prdid){
                sf:=1;
                sIndex:=si;
            }else{
                si+=1;
            }
        };
        if(sf==1){
            if(compsoldc[sIndex]==cnsrid){
                return "Genuine Product";
            }else{
                return "Fake Product";
            }
        }else{
            return "Fake Product";
        }
    };
//     // Function to get all audit records
//     public query func getAuditRecords() : async [AuditRecord] {
//         return auditRecords;
//     };
    public query func getCompSoldRecords() : async[SellerToConsumerRecord]{
        return sellerconsumerRecords;
        
    }
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
  
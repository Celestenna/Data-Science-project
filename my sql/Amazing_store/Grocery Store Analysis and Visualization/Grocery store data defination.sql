create database if not exists amazing_store;

use amazing_store;



CREATE TABLE `orders` (
    `OrderID` int  NOT NULL ,
    `CustomerID` int  NOT NULL ,
    `EmployeeID` int  NOT NULL ,
    `OrderDate` date  NOT NULL ,
    `ShipperID` int  NOT NULL ,
    PRIMARY KEY (
        `OrderID`
    )
);

CREATE TABLE `employees` (
    `EmployeeID` int  NOT NULL ,
    `LastName` varchar(225)  NOT NULL ,
    `FirstName` varchar(225)  NOT NULL ,
    `BirthDate` Date  NOT NULL ,
    `Photo` varchar(225)  NOT NULL ,
    `Notes` text  NOT NULL ,
    PRIMARY KEY (
        `EmployeeID`
    )
);

CREATE TABLE `customers` (
    `CustomerID` int  NOT NULL ,
    `CustomerName` varchar(225)  NOT NULL ,
    `ContactName` varchar(225)  NOT NULL ,
    `Address` varchar(225)  NOT NULL ,
    `City` varchar(225)  NOT NULL ,
    `PostalCode` varchar(225)  NOT NULL ,
    `Country` varchar(225)  NOT NULL ,
    PRIMARY KEY (
        `CustomerID`
    )
);

CREATE TABLE `shippers` (
    `ShipperID` int  NOT NULL ,
    `ShipperName` varchar(225)  NOT NULL ,
    `Phone` varchar(225)  NOT NULL ,
    PRIMARY KEY (
        `ShipperID`
    )
);

CREATE TABLE `products` (
    `ProductID` int  NOT NULL ,
    `ProductName` varchar(225)  NOT NULL ,
    `SupplierID` int  NOT NULL ,
    `CategoryID` int  NOT NULL ,
    `Unit` varchar(225)  NOT NULL ,
    `Price` double  NOT NULL ,
    PRIMARY KEY (
        `ProductID`
    )
);

CREATE TABLE `order_details` (
    `OrderDetailsID` int  NOT NULL ,
    `OrderID` int  NOT NULL ,
    `ProductId` int  NOT NULL ,
    `Quantity` int  NOT NULL ,
    PRIMARY KEY (
        `OrderDetailsID`
    )
);

CREATE TABLE `categories` (
    `CategoryID` int  NOT NULL ,
    `CategoryName` varchar(255)  NOT NULL ,
    `Description` varchar(225)  NOT NULL ,
    PRIMARY KEY (
        `CategoryID`
    )
);

CREATE TABLE `suppliers` (
    `SupplierID` int  NOT NULL ,
    `SupplierName` varchar(225)  NOT NULL ,
    `ContactName` varchar(225)  NOT NULL ,
    `Address` varchar(225)  NOT NULL ,
    `City` varchar(225)  NOT NULL ,
    `PostalCode` varchar(225)  NOT NULL ,
    `Country` varchar(225)  NOT NULL ,
    `Phone` varchar(225)  NOT NULL ,
    PRIMARY KEY (
        `SupplierID`
    )
);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_CustomerID` FOREIGN KEY(`CustomerID`)
REFERENCES `customers` (`CustomerID`);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_EmployeeID` FOREIGN KEY(`EmployeeID`)
REFERENCES `employees` (`EmployeeID`);

ALTER TABLE `orders` ADD CONSTRAINT `fk_orders_ShipperID` FOREIGN KEY(`ShipperID`)
REFERENCES `shippers` (`ShipperID`);

ALTER TABLE `products` ADD CONSTRAINT `fk_products_SupplierID` FOREIGN KEY(`SupplierID`)
REFERENCES `suppliers` (`SupplierID`);

ALTER TABLE `products` ADD CONSTRAINT `fk_products_CategoryID` FOREIGN KEY(`CategoryID`)
REFERENCES `categories` (`CategoryID`);

ALTER TABLE `order_details` ADD CONSTRAINT `fk_order_details_OrderID` FOREIGN KEY(`OrderID`)
REFERENCES `orders` (`OrderID`);

ALTER TABLE `order_details` ADD CONSTRAINT `fk_order_details_ProductId` FOREIGN KEY(`ProductId`)
REFERENCES `products` (`ProductID`);
desc table categories;
select *
from categories;


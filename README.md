<h1 align="center" id="urls">MySQL eCommerce Database and API</h1>
<h4 align="center">Get an eCommerce database up and running quicker with a ready-made MVP (Minimum Viable Product) solution.</h4>

<p align="center">
<a href="http://amarlearning.mit-license.org/"><img src="https://img.shields.io/pypi/l/pyzipcode-cli.svg" alt="mit license"></a>
<a href="https://github.com/runninguru/MySQL-eCommerce/issues"><img src="https://camo.githubusercontent.com/926d8ca67df15de5bd1abac234c0603d94f66c00/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f636f6e747269627574696f6e732d77656c636f6d652d627269676874677265656e2e7376673f7374796c653d666c6174" alt="Issue"></a>
<img src="http://kylebirch.info/images/buildfailing.svg">
</p>
Includes scripts, functions, and procedures you will need to implement an eCommerce website without needing to reinvent the wheel.

## OK, so what can it do?

<ul>
<li>This is not designed to support international currency. It is designed for use in the USA (and the US Dollar), but if it will work in a different country/currency, you are free to try it. Remember to follow all local and federal regulations on transactions and record-keeping.</li>
<li>Store & Catalog your entire inventory.</li>
<li>Stores and automates pricing information on all products in your catalog, including base-price, seasonal pricing, discounts, etc.</li>
<li>Maintain information on all website users, including account information, credit cards, billing & shipping addresses, contact information, etc.</li>
<li>No 'group accounts', or in other words, it's designed for one account per person.</li>
</ul>


## Features I might support in future releases

Support for tax-exempt entities, as well as 'group accounts' or other entities, rather than just 'individual accounts'.

## Tables

<ul>

<li>system_user
<ul>
<li>A list of all database users who have permission to access this database.</li>
</ul>
</li>

<li>common_lookup
<ul>
<li>When a column in any other table in this database is only allowed one of a few specific values, the value in that column is usually a reference to the common_lookup table in the form of a Foreign Key.</li>
<li>The most common use-case of the common_lookup table is to enforce business logic.</li>
<li>A column name that ends in _type is always a foreign key reference to common_lookup.common_lookup_id</li>
<li>Example: In the credit_card.credit_card_type column, we can enforce approved values based on rows in the common_lookup table. If your business decides that you will only support Visa, Master Card and Discover Card, then credit_card.credit_card_type will allow only one of 3 references to the common_lookup_table.</li>
</ul>
</li>

<li>account
<ul>
<li>Used to store essential account information and foreign keys for relational data (contact, credit_card, transaction, and address tables.</li>
</ul>
</li>

<li>contact
<ul>
<li>Represents all of the contact information for an individual account. Keeping contact and account tables separate will makes it easier to accommodate multi-user accounts in the future.</li>
<li>For now, there is a 1-to-1 relationship between contact and account.</li>
</ul>
</li>

<li>credit_card
<ul>
<li>Stores credit card information for each credit card.</li>
<li>Each account can have 1-to-many credit cards.</li>
</ul>
</li>

<li>transaction
<ul>
<li>Represents a single transaction. Has a foreign key reference to account. An account may have 1-to-many transactions.</li>
<li>NOTE: the transaction.transaction_date column may seem redundant in light of the transaction.creation_date column, but that is not true. The transaction.creation_date column is used to track the date each row was created, while transaction.transaction_date tracks the date of the transaction. If the data type of a column in the table needs to be changed, for example, you might transfer the data to a temporary table, drop the table, and re-create the table with the new changes, in which case the value in the transaction.creation_date column will change, but the transaction.transaction_date column will not.</li>
</ul>
</li>

<li>transaction_item
<ul>
<li>An item that was purchased in a particular transaction.</li>
<li>Each transaction can have 1-to-many transaction-items.</li>
</ul>
</li>

<li>item
<ul>
<li>A inventory of all products available to be sold.</li>
</ul>
</li>

<li>item_category
<ul>
<li></li>
</ul>
</li>

<li>item_subcategory
<ul>
<li></li>
</ul>
</li>

<li>price
<ul>
<li></li>
</ul>
</li>

<li>telephone
<ul>
<li></li>
</ul>
</li>

<li>billing_address
<ul>
<li></li>
</ul>
</li>

<li>shipping_address
<ul>
<li></li>
</ul>
</li>

<li>state
<ul>
<li></li>
</ul>
</li>

<li>city
<ul>
<li></li>
</ul>
</li>

<li>street_address
<ul>
<li></li>
</ul>
</li>

<li>postal_code
<ul>
<li></li>
</ul>
</li>
</ul>

## Contributing

Feel free to contribute!

### Code Style & Conventions

<ul>
<li>Each Primary Key index starts at 1001. This way, each table has 1000 rows you can experiment with when debugging, altering database designs, etc.</li>
<li>A column whose name ends in '_type' shall be a foreign key reference to common_lookup.common_lookup_id.</li>
<li>Capitalize reserved words.</li>
<li>Main keywords on new line.</li>
<li>commas before columns.</li>
<li>indent using tab.</li>
<li>Each table has 4 columns used to track data entry:

<ul>
<li>created_by</li>
<li>creation_date</li>
<li>last_updated_by</li>
<li>last_update_date</li>
</ul>

</li>

</ul>
These columns are not designed to be a robust logging or auditing mechanism. Think of them as a development/audit tool used to track the <i>most recent</i> changes made to each row in a table. The created_by & last_upated_by columns are populated with data based on the current database user. At the same time, though, permission to edit data in these columns is restricted, and values in these columns are updated/inserted with triggers. That way, when a db user commits an INSERT or UPDATE, a trigger automatically populates these four columns with the appropriate information.  

## Contributors
[:arrow_up:\[Back to Top\]](https://github.com/runninguru/MySQL-eCommerce)

Following is a list of contributors:

Be the first!

## Issues
[:arrow_up:\[Back to Top\]](https://github.com/runninguru/MySQL-eCommerce)

You can report the bugs at the [issue tracker](https://github.com/runninguru/MySQL-eCommerce/issues)

***

## License
[:arrow_up:\[Back to Top\]](https://github.com/runninguru/MySQL-eCommerce)

Kyle Birch([@runninguru](http://github.com/runninguru)) under [MIT License](https://choosealicense.com/licenses/mit/) 

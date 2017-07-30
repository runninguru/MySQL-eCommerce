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
</li>
<li>common_lookup>
</li>
<li>account
</li>
<li>contact
</li>
<li>credit_card
</li>
<li>transaction
</li>
<li>transaction_item
</li>
<li>item
</li>
<li>telephone
</li>
<li>billing_address
</li>
<li>shipping_address
</li>
<li>state
</li>
<li>city
</li>
<li>street_address
</li>
<li>postal_code
</li>
</ul>





## Contributing

Feel free to contribute!

### Code Style & Conventions

<ul>

<li>Capitalize reserved words</li>
<li>Main keywords on new line</li>
<li>commas before columns</li>
<li>indent using tab</li>
<li>Each table has 4 columns used to track data entry:

<ul>
<li>created_by</li>
<li>creation_date</li>
<li>last_updated_by</li>
<li>last_update_date</li>
</ul>

</li>

</ul>
These columns are not designed to be a robust logging or auditing mechanism. Think of it as a development/audit tool used to track the behavior of changes made to the database. The created_by & creation_date columns are populated with data based on the database user. At the same time, though, permission to edit data in these columns is restricted, and values in these columns are updated/insert with triggers. That way, you can have users INSERT or UPDATE who don't have permission to alter these columns

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

Kyle Birch([@amarlearning](http://github.com/amarlearning)) under [MIT License](https://choosealicense.com/licenses/mit/) 

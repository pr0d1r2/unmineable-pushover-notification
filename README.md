# unmineable-workers

Send pushover notifications from unmineable accounts. Running every five
minutes on systemd.

## Why?

[Unmineable](https://www.unmineable.com) has no notification services.

## Install

Tested on Ubuntu 20.04 server.

```bash
git clone https://github.com/pr0d1r2/unmineable-pushover-notification
cd unmineable-pushover-notification
bash install.sh
```

## Configuration

### Unmineable accounts

You need to obtain account identifier symilar to `aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee`.
Go to your account in [unmineable](https://www.unmineable.com) with web
browser and using inspect acquire it from requests.

Put it along with expected workers:

```bash
echo "aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee:expected_host1,expected_host2" >> /etc/unmineable-accounts
```

### Pushover devices

Acquire credentials for app from [pushover website.](https://pushover.net)

```bash
echo "userxxxxxxxxxxxxxxxxxxxxxxxxxx:applicationyyyyyyyyyyyyyyyyyyy' >> /etc/unmineable-pushover-devices
```

## Related

There are also:
- [unmineable-miner](https://github.com/pr0d1r2/unmineable-miner)
- [unmineable-workers](https://github.com/pr0d1r2/unmineable-workers)

## Support

Consider using my [unmineable referral link](https://www.unmineable.com/?ref=3792-egij) (0.75% pool fee instead of 1% for you as well) or [donate](https://github.com/pr0d1r2/donate) or both.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

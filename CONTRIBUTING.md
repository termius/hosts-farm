# Contributing

We love pull requests from everyone.

Fork, then clone the repo:

```bash
git clone git@github.com:your-username/sa-ssh-server-farm.git
```

Start ssh services:

```bash
docker-compose up
```

Make sure you can connect to service you want:

    ssh [username]@$DOCKER_HOST [-p $SERVICE_PORT]


Push to your fork and [submit a pull request][pr].

[pr]: https://github.com/Crystalnix/sa-ssh-server-farm/compare/

At this point you're waiting on us. We like to at least comment on pull requests
within three business days (and, typically, one business day). We may suggest
some changes or improvements or alternatives.

Some things that will increase the chance that your pull request is accepted:

* Write a [good commit message][commit].

[commit]: http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

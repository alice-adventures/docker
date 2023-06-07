#!/bin/bash

ttyd --port 8086 --cwd $HOME/alice/ --max-clients 0 --url-arg --client-option fontSize=15 bash

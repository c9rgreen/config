function claude-qwen --description 'Claude Code against the Jetstream-hosted Qwen (LiteLLM) endpoint'
    # Start the local shim (fixes mid-conversation system messages) if not already running.
    if not nc -z 127.0.0.1 8787 2>/dev/null
        nohup python3 -I ~/.claude/jetstream-shim.py 8787 >/dev/null 2>&1 &
        disown
        for i in (seq 20)
            nc -z 127.0.0.1 8787 2>/dev/null; and break
            sleep 0.1
        end
    end
    claude --settings ~/.claude/settings.jetstream.json $argv
end

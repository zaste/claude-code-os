#!/usr/bin/env node

/**
 * Claude Code OS Web Installer
 * This script is served at https://claude.dev/os
 * and provides a one-line installation experience
 */

const https = require('https');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Colors for terminal output
const colors = {
    reset: '\x1b[0m',
    bright: '\x1b[1m',
    red: '\x1b[31m',
    green: '\x1b[32m',
    yellow: '\x1b[33m',
    blue: '\x1b[34m',
};

const log = {
    info: (msg) => console.log(`${colors.blue}ℹ${colors.reset}  ${msg}`),
    success: (msg) => console.log(`${colors.green}✓${colors.reset}  ${msg}`),
    warning: (msg) => console.log(`${colors.yellow}⚠${colors.reset}  ${msg}`),
    error: (msg) => console.log(`${colors.red}✗${colors.reset}  ${msg}`),
};

const REPO_BASE = 'https://raw.githubusercontent.com/zaste/claude-code-os/main';

/**
 * Detect the current environment
 */
function detectEnvironment() {
    if (process.env.CODESPACES) return 'codespaces';
    if (process.env.GITPOD_WORKSPACE_ID) return 'gitpod';
    if (process.env.VSCODE_REMOTE_CONTAINERS) return 'devcontainer';
    return 'local';
}

/**
 * Detect project type by looking at files
 */
function detectProjectType() {
    if (fs.existsSync('package.json')) {
        try {
            const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8'));
            const deps = { ...pkg.dependencies, ...pkg.devDependencies };
            
            if (deps.react || deps['react-dom']) return 'react';
            if (deps.vue) return 'vue';
            if (deps.express || deps.fastify || deps.koa) return 'node';
            return 'node';
        } catch {
            return 'node';
        }
    }
    
    if (fs.existsSync('requirements.txt') || fs.existsSync('setup.py') || fs.existsSync('pyproject.toml')) {
        return 'python';
    }
    
    if (fs.existsSync('go.mod')) return 'go';
    if (fs.existsSync('Cargo.toml')) return 'rust';
    if (fs.existsSync('pom.xml') || fs.existsSync('build.gradle')) return 'java';
    
    return 'generic';
}

/**
 * Download a file from URL
 */
function downloadFile(url) {
    return new Promise((resolve, reject) => {
        https.get(url, (response) => {
            if (response.statusCode === 200) {
                let data = '';
                response.on('data', chunk => data += chunk);
                response.on('end', () => resolve(data));
            } else {
                reject(new Error(`HTTP ${response.statusCode}`));
            }
        }).on('error', reject);
    });
}

/**
 * Main installation function
 */
async function install() {
    console.log(`\n${colors.blue}${colors.bright}🧠 Claude Code OS Installer${colors.reset}`);
    console.log('=================================\n');
    
    // Detect environment and project
    const environment = detectEnvironment();
    const projectType = detectProjectType();
    
    log.info(`Environment: ${colors.bright}${environment}${colors.reset}`);
    log.info(`Project Type: ${colors.bright}${projectType}${colors.reset}\n`);
    
    // Check if CLAUDE.md already exists
    if (fs.existsSync('CLAUDE.md')) {
        log.warning('CLAUDE.md already exists');
        console.log('\nDo you want to update it? This will backup the existing file.');
        // In a real implementation, we'd ask for user input here
        // For now, we'll create a backup
        const timestamp = new Date().toISOString().replace(/:/g, '-').split('.')[0];
        fs.copyFileSync('CLAUDE.md', `CLAUDE.md.backup.${timestamp}`);
        log.success(`Backed up to CLAUDE.md.backup.${timestamp}`);
    }
    
    try {
        // Download appropriate CLAUDE.md
        log.info('Downloading CLAUDE.md...');
        
        let claudeMdUrl = `${REPO_BASE}/CLAUDE.md`;
        if (projectType !== 'generic') {
            const templateUrl = `${REPO_BASE}/templates/${projectType}/CLAUDE.md`;
            try {
                const templateContent = await downloadFile(templateUrl);
                fs.writeFileSync('CLAUDE.md', templateContent);
                log.success(`Downloaded ${projectType}-specific CLAUDE.md`);
            } catch {
                // Fallback to generic
                const genericContent = await downloadFile(claudeMdUrl);
                fs.writeFileSync('CLAUDE.md', genericContent);
                log.success('Downloaded generic CLAUDE.md');
            }
        } else {
            const content = await downloadFile(claudeMdUrl);
            fs.writeFileSync('CLAUDE.md', content);
            log.success('Downloaded CLAUDE.md');
        }
        
        // Success message
        console.log(`\n${colors.green}${colors.bright}🎉 Claude Code OS installed successfully!${colors.reset}\n`);
        
        console.log(`${colors.bright}📖 Next steps:${colors.reset}`);
        console.log('  1. Open Claude Code in this directory');
        console.log('  2. Claude will automatically activate the OS');
        console.log('  3. Watch your productivity soar!\n');
        
        console.log(`${colors.bright}💡 Tips:${colors.reset}`);
        console.log('  • Check CLAUDE.md to understand the protocols');
        console.log('  • Run with --advanced for power user features');
        console.log('  • Join the community at github.com/zaste/claude-code-os\n');
        
        // Analytics
        try {
            const analyticsData = JSON.stringify({
                version: '1.0.0',
                environment,
                project_type: projectType,
                timestamp: Date.now()
            });
            
            const options = {
                hostname: 'analytics.claude.dev',
                path: '/install',
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Content-Length': analyticsData.length
                }
            };
            
            const req = https.request(options);
            req.write(analyticsData);
            req.end();
        } catch {
            // Ignore analytics errors
        }
        
    } catch (error) {
        log.error(`Installation failed: ${error.message}`);
        console.log('\nPlease try manual installation:');
        console.log(`  curl -s ${REPO_BASE}/CLAUDE.md > CLAUDE.md\n`);
        process.exit(1);
    }
}

// Run installer
if (require.main === module) {
    install();
}
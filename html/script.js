let config = {};
let logoContainer = null;
let serverLogo = null;
let isInitialized = false;
let animationFrame = null;

function initializeElements() {
    logoContainer = document.getElementById('logo-container');
    serverLogo = document.getElementById('server-logo');
    
    if (!logoContainer || !serverLogo) {
        setTimeout(initializeElements, 50);
        return;
    }
    
    isInitialized = true;
}

function applyConfiguration(cfg) {
    config = cfg;
    
    if (!isInitialized) return;
    
    logoContainer.className = `logo-hidden ${config.position}`;
    
    if (config.size) {
        serverLogo.style.width = config.size.width + 'px';
        serverLogo.style.height = config.size.height + 'px';
    }
    
    if (config.offset) {
        const position = config.position;
        
        if (position.includes('top')) {
            logoContainer.style.top = config.offset.y + 'px';
        } else if (position.includes('bottom')) {
            logoContainer.style.bottom = config.offset.y + 'px';
        }
        
        if (position.includes('left')) {
            logoContainer.style.left = config.offset.x + 'px';
        } else if (position.includes('right')) {
            logoContainer.style.right = config.offset.x + 'px';
        }
    }
    
    if (config.opacity !== undefined) {
        logoContainer.style.setProperty('--logo-opacity', config.opacity);
        const visibleClass = logoContainer.classList.contains('logo-visible');
        if (visibleClass) {
            logoContainer.style.opacity = config.opacity;
        }
    }
    
    if (config.animations && config.animations.duration) {
        const duration = config.animations.duration / 1000;
        logoContainer.style.transitionDuration = duration + 's';
    }
}

function toggleLogo(visible, animate = true) {
    if (!isInitialized) return;
    
    if (animationFrame) {
        cancelAnimationFrame(animationFrame);
    }
    
    animationFrame = requestAnimationFrame(() => {
        performToggle(visible, animate);
    });
}

function performToggle(visible, animate) {
    if (!animate) {
        logoContainer.style.transition = 'none';
    }
    
    logoContainer.classList.remove('logo-visible', 'logo-hidden');
    
    if (visible) {
        logoContainer.classList.add('logo-visible');
        if (config.opacity !== undefined) {
            logoContainer.style.opacity = config.opacity;
        }
    } else {
        logoContainer.classList.add('logo-hidden');
    }
    
    if (!animate) {
        setTimeout(() => {
            if (config.animations && config.animations.duration) {
                const duration = config.animations.duration / 1000;
                logoContainer.style.transition = `opacity ${duration}s ${config.animations.easing || 'ease-in-out'}, transform ${duration}s ${config.animations.easing || 'ease-in-out'}`;
            }
        }, 10);
    }
}

window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch(data.type) {
        case 'initialize':
            applyConfiguration(data.config);
            break;
            
        case 'toggleLogo':
            toggleLogo(data.visible, data.animate);
            break;
            
        case 'mapToggle':
            toggleLogo(data.visible, data.animate);
            break;
            
        default:
            break;
    }
});

document.addEventListener('DOMContentLoaded', function() {
    initializeElements();
});
